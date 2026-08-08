#!/usr/bin/env python3
"""
Production logging audit helper.
- Auth / recharge / payment files: REMOVE print/debugPrint/developer.log statements
  and PrettyDioLogger usage.
- All other lib/ files: replace print/debugPrint with AppLogger.d, wrap PrettyDioLogger
  in kDebugMode, route developer.log through AppLogger.
"""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1] / "lib"
APP_LOGGER_IMPORT = "import 'package:astro_brahmand/utill/app_logger.dart';"
FOUNDATION_IMPORT = "import 'package:flutter/foundation.dart';"

# Remove logging entirely (sensitive auth + payment/recharge).
REMOVE_RELATIVE = {
    "view/screen/login/controller/login_controller.dart",
    "view/screen/login/controller/otp_controller.dart",
    "controller/auth_controller.dart",
    "view/screen/wallet/controller/wallet_controller.dart",
    "controller/razorpay_controller.dart",
    "controller/cash_free_controller.dart",
    "controller/phonepe_controller.dart",
    "controller/ccavenue_controller.dart",
    "view/screen/webview/payment_webview_screen.dart",
    "view/screen/webview/ccavenue_webview_screen.dart",
    "view/screen/checkout/checkout_screen.dart",
    "view/screen/payment/razorpay_qr_payment_screen.dart",
}

# PrettyDioLogger: remove entirely from these (auth/payment).
REMOVE_PRETTY_DIO = {
    "view/screen/login/controller/login_controller.dart",
    "controller/razorpay_controller.dart",
}

SKIP_FILES = {
    "utill/app_logger.dart",
}


def split_lines_keepends(text: str) -> list[str]:
    return text.splitlines(keepends=True)


def strip_keepends(line: str) -> str:
    return line.rstrip("\r\n")


def is_comment_or_string_only_line(code: str) -> bool:
    s = code.strip()
    return s.startswith("//") or s.startswith("///") or s.startswith("*")


def find_call_span(text: str, start: int, func_name: str) -> tuple[int, int] | None:
    """Return [start, end) of a function call func_name(...) starting at start."""
    m = re.match(rf"{func_name}\s*\(", text[start:])
    if not m:
        return None
    i = start + m.end()  # position after '('
    depth = 1
    in_single = False
    in_double = False
    in_triple_single = False
    in_triple_double = False
    in_raw = False
    escape = False
    while i < len(text):
        ch = text[i]
        nxt2 = text[i : i + 3]

        if in_triple_single:
            if nxt2 == "'''":
                in_triple_single = False
                i += 3
                continue
            i += 1
            continue
        if in_triple_double:
            if nxt2 == '"""':
                in_triple_double = False
                i += 3
                continue
            i += 1
            continue
        if in_single:
            if escape:
                escape = False
            elif ch == "\\":
                escape = True
            elif ch == "'":
                in_single = False
            i += 1
            continue
        if in_double:
            if escape:
                escape = False
            elif ch == "\\":
                escape = True
            elif ch == '"':
                in_double = False
            i += 1
            continue

        # not in string
        if nxt2 == "'''":
            in_triple_single = True
            i += 3
            continue
        if nxt2 == '"""':
            in_triple_double = True
            i += 3
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
            if depth == 0:
                end = i + 1
                # optional trailing semicolon
                j = end
                while j < len(text) and text[j] in " \t":
                    j += 1
                if j < len(text) and text[j] == ";":
                    end = j + 1
                return start, end
        i += 1
    return None


def line_starts_in_block_comment(lines: list[str], idx: int) -> bool:
    """Rough check if line is inside /* */ (rare in this codebase)."""
    text = "".join(lines[: idx + 1])
    # Count /* and */ before end of this line, ignoring // comments crudely
    opens = len(re.findall(r"/\*", text))
    closes = len(re.findall(r"\*/", text))
    # if more opens than closes before this line ends, and current line doesn't start the open alone awkwardly
    before = "".join(lines[:idx])
    opens_b = len(re.findall(r"/\*", before))
    closes_b = len(re.findall(r"\*/", before))
    return opens_b > closes_b


def is_in_line_comment(line: str, col: int) -> bool:
    # if // appears before col outside strings — simplified
    i = 0
    in_s = False
    in_d = False
    while i < col and i < len(line):
        ch = line[i]
        if not in_s and not in_d and line[i : i + 2] == "//":
            return True
        if not in_d and ch == "'" and not in_s:
            in_s = True
        elif in_s and ch == "'":
            in_s = False
        elif not in_s and ch == '"' and not in_d:
            in_d = True
        elif in_d and ch == '"':
            in_d = False
        i += 1
    return False


def remove_statement_containing(text: str, func_names: list[str]) -> tuple[str, int]:
    """Remove whole statements that are print/debugPrint/developer.log calls,
    including wrapping `if (kDebugMode) { ... }` when the block only contains those logs.
    """
    removed = 0
    # Work on full text with call-span finder repeatedly
    pattern = re.compile(r"\b(" + "|".join(func_names) + r")\s*\(")

    while True:
        # skip matches in comments
        match = None
        for m in pattern.finditer(text):
            # check if this match is in a // comment on its line
            line_start = text.rfind("\n", 0, m.start()) + 1
            line_end = text.find("\n", m.start())
            if line_end < 0:
                line_end = len(text)
            line = text[line_start:line_end]
            col = m.start() - line_start
            stripped = line.lstrip()
            if stripped.startswith("//") or stripped.startswith("///"):
                continue
            if is_in_line_comment(line, col):
                continue
            # skip if already AppLogger
            before = text[max(0, m.start() - 20) : m.start()]
            if before.endswith("AppLogger."):
                continue
            match = m
            break
        if not match:
            break

        span = find_call_span(text, match.start(), match.group(1))
        if not span:
            # avoid infinite loop
            text = text[: match.start()] + text[match.end() :]
            removed += 1
            continue

        start, end = span

        # Expand to full line(s) / if-block
        # Walk left to include indentation and optional `if (kDebugMode) {`
        block_start = start
        # include whitespace before call on same line
        while block_start > 0 and text[block_start - 1] in " \t":
            block_start -= 1

        # If preceded by `if (kDebugMode) {` on same or previous lines
        prefix = text[:block_start]
        # Try match trailing if (kDebugMode) { with optional whitespace/newlines
        if_match = re.search(
            r"(?:^|\n)([ \t]*)if\s*\(\s*kDebugMode\s*\)\s*\{\s*$",
            prefix,
        )
        consumed_if = False
        indent = ""
        if if_match:
            # verify the call is the only content until closing brace after end
            after = text[end:]
            close_m = re.match(r"\s*\}", after)
            if close_m:
                # check nothing else meaningful between end and }
                between = after[: close_m.start()]
                if between.strip() == "" or between.strip() == ";":
                    block_start = if_match.start(1) if if_match.start(1) >= 0 else if_match.start()
                    # if match started with \n, keep the newline by starting after it
                    if text[if_match.start()] == "\n":
                        block_start = if_match.start() + 1
                    else:
                        block_start = if_match.start()
                    end = end + close_m.end()
                    consumed_if = True
                    indent = if_match.group(1)

        # Also handle one-liner: if (kDebugMode) { print(...); }
        one_liner = re.search(
            r"([ \t]*)if\s*\(\s*kDebugMode\s*\)\s*\{\s*$",
            text[max(0, start - 80) : start],
        )
        # Already handled above for multiline; for same-line:
        same_line_if = re.match(
            r"([ \t]*)if\s*\(\s*kDebugMode\s*\)\s*\{",
            text[text.rfind("\n", 0, start) + 1 : start],
        )
        if not consumed_if and same_line_if:
            line_start = text.rfind("\n", 0, start) + 1
            after = text[end:]
            close_m = re.match(r"\s*\}", after)
            if close_m:
                between = after[: close_m.start()]
                if between.strip() in ("", ";"):
                    block_start = line_start
                    end = end + close_m.end()
                    consumed_if = True

        # Expand to consume trailing newline
        if end < len(text) and text[end] == "\r":
            end += 1
        if end < len(text) and text[end] == "\n":
            end += 1

        # If the whole line becomes empty after removal of only the call
        # (call was entire statement line)
        text = text[:block_start] + text[end:]
        removed += 1

    return text, removed


def replace_calls(text: str, func_names: list[str], replacement: str = "AppLogger.d") -> tuple[str, int]:
    """Replace print/debugPrint calls with AppLogger.d, preserving args.
    developer.log is converted to AppLogger.d with first positional message only when simple.
    """
    changed = 0
    pattern = re.compile(r"\b(" + "|".join(func_names) + r")\s*\(")

    # Process from end to start so offsets stay valid
    matches = []
    for m in pattern.finditer(text):
        line_start = text.rfind("\n", 0, m.start()) + 1
        line_end = text.find("\n", m.start())
        if line_end < 0:
            line_end = len(text)
        line = text[line_start:line_end]
        col = m.start() - line_start
        stripped = line.lstrip()
        if stripped.startswith("//") or stripped.startswith("///"):
            continue
        if is_in_line_comment(line, col):
            continue
        before = text[max(0, m.start() - 20) : m.start()]
        if before.endswith("AppLogger."):
            continue
        span = find_call_span(text, m.start(), m.group(1))
        if not span:
            continue
        matches.append((m.group(1), span[0], span[1]))

    for name, start, end in reversed(matches):
        call = text[start:end]
        # strip trailing semicolon for rebuild
        has_semi = call.rstrip().endswith(";")
        core = call.rstrip()
        if has_semi:
            core = core[:-1].rstrip()

        # core is name(...)
        args_match = re.match(rf"{name}\s*\((.*)\)$", core, re.DOTALL)
        if not args_match:
            continue
        args = args_match.group(1).strip()

        if name == "developer.log":
            # developer.log(message, error: e) -> AppLogger.e(message, error: e) if error present
            if "error:" in args or "error :" in args:
                new_call = f"AppLogger.e({args})"
            else:
                new_call = f"AppLogger.d({args})"
        else:
            new_call = f"{replacement}({args})"

        if has_semi:
            new_call += ";"

        text = text[:start] + new_call + text[end:]
        changed += 1

    return text, changed


def simplify_kdebug_wrappers(text: str) -> str:
    """Replace `if (kDebugMode) { AppLogger.d(...); }` with just `AppLogger.d(...);`."""
    # one-liner
    text = re.sub(
        r"if\s*\(\s*kDebugMode\s*\)\s*\{\s*(AppLogger\.[de]\s*\(.*?\);)\s*\}",
        r"\1",
        text,
        flags=re.DOTALL,
    )
    # multi-line single statement blocks
    pattern = re.compile(
        r"([ \t]*)if\s*\(\s*kDebugMode\s*\)\s*\{\s*\n"
        r"([ \t]*AppLogger\.[de]\s*\([\s\S]*?\);\s*\n)"
        r"[ \t]*\}",
    )

    def repl(m: re.Match) -> str:
        indent = m.group(1)
        body = m.group(2).lstrip()
        return f"{indent}{body}"

    prev = None
    while prev != text:
        prev = text
        text = pattern.sub(repl, text)
    return text


def ensure_import(text: str, import_line: str) -> str:
    if import_line in text:
        return text
    # insert after last import
    imports = list(re.finditer(r"^import\s+['\"].*?['\"];\s*\n", text, re.MULTILINE)
    )
    if imports:
        last = imports[-1]
        return text[: last.end()] + import_line + "\n" + text[last.end() :]
    # after library/part or at top
    return import_line + "\n" + text


def remove_unused_pretty_dio_import(text: str) -> str:
    if "PrettyDioLogger" in text:
        return text
    return re.sub(
        r"^import\s+['\"]package:pretty_dio_logger/pretty_dio_logger\.dart['\"];\s*\n",
        "",
        text,
        flags=re.MULTILINE,
    )


def wrap_or_remove_pretty_dio(text: str, remove: bool) -> str:
    # Find `_dio.interceptors.add(PrettyDioLogger(...));` possibly with comment `// logger`
    pattern = re.compile(
        r"[ \t]*(?://\s*logger\s*\n)?[ \t]*_dio\.interceptors\.add\(\s*PrettyDioLogger\s*\([\s\S]*?\)\s*\)\s*;\s*\n?",
    )
    if remove:
        return pattern.sub("", text)

    def wrap(m: re.Match) -> str:
        block = m.group(0)
        if "kDebugMode" in text[max(0, m.start() - 40) : m.start()]:
            return block  # already guarded nearby — leave
        # indent
        indent_m = re.match(r"([ \t]*)", block)
        indent = indent_m.group(1) if indent_m else "    "
        inner = block
        # re-indent inner by 2 spaces
        inner_lines = []
        for line in block.splitlines(True):
            if line.strip():
                inner_lines.append(indent + "  " + line.lstrip() if line.startswith(indent) else "  " + line)
            else:
                inner_lines.append(line)
        # simpler: wrap as-is
        return (
            f"{indent}if (kDebugMode) {{\n"
            f"{block.rstrip()}\n"
            f"{indent}}}\n"
        )

    # Avoid double wrap
    if re.search(r"if\s*\(\s*kDebugMode\s*\)\s*\{[\s\S]{0,80}PrettyDioLogger", text):
        return text
    return pattern.sub(wrap, text)


def remove_unused_foundation_if_needed(text: str) -> str:
    # Keep foundation if kDebugMode / kReleaseMode / etc still used
    if re.search(r"\bkDebugMode\b|\bkReleaseMode\b|\bkProfileMode\b|\bdebugPrint\b|\bfoundation\b", text):
        return text
    # only remove if we added it unnecessarily — don't remove if other foundation symbols
    # safer: leave foundation imports alone
    return text


def process_file(path: Path) -> dict:
    rel = str(path.relative_to(ROOT)).replace("\\", "/")
    if rel in SKIP_FILES:
        return {"file": rel, "action": "skip"}

    original = path.read_text(encoding="utf-8")
    text = original
    stats = {"file": rel, "removed": 0, "replaced": 0, "pretty": None}

    is_remove = rel in REMOVE_RELATIVE

    # PrettyDio first
    if "PrettyDioLogger" in text:
        if rel in REMOVE_PRETTY_DIO or is_remove and rel in REMOVE_PRETTY_DIO:
            text = wrap_or_remove_pretty_dio(text, remove=True)
            text = remove_unused_pretty_dio_import(text)
            stats["pretty"] = "removed"
        elif is_remove and "PrettyDioLogger" in text and rel in {
            "view/screen/login/controller/login_controller.dart",
            "controller/razorpay_controller.dart",
        }:
            text = wrap_or_remove_pretty_dio(text, remove=True)
            text = remove_unused_pretty_dio_import(text)
            stats["pretty"] = "removed"
        else:
            # For remove-list payment files without PrettyDio — skip
            if not is_remove:
                before = text
                text = wrap_or_remove_pretty_dio(text, remove=False)
                if text != before:
                    text = ensure_import(text, FOUNDATION_IMPORT)
                    stats["pretty"] = "wrapped"
            # login/razorpay already handled

    # Explicit remove PrettyDio from login & razorpay always
    if rel in REMOVE_PRETTY_DIO and "PrettyDioLogger" in text:
        text = wrap_or_remove_pretty_dio(text, remove=True)
        text = remove_unused_pretty_dio_import(text)
        stats["pretty"] = "removed"

    if is_remove:
        text, n = remove_statement_containing(
            text, ["print", "debugPrint", "developer.log"]
        )
        stats["removed"] = n
        # clean empty kDebugMode blocks left behind
        text = re.sub(
            r"[ \t]*if\s*\(\s*kDebugMode\s*\)\s*\{\s*\}[ \t]*\n?",
            "",
            text,
        )
        # remove orphan printLongString helpers that only logged tokens? leave code
    else:
        # wrap pretty dio for remaining files
        if "PrettyDioLogger" in text and stats["pretty"] is None:
            before = text
            text = wrap_or_remove_pretty_dio(text, remove=False)
            if text != before:
                text = ensure_import(text, FOUNDATION_IMPORT)
                stats["pretty"] = "wrapped"

        text, n = replace_calls(text, ["print", "debugPrint", "developer.log"])
        stats["replaced"] = n
        if n > 0:
            text = ensure_import(text, APP_LOGGER_IMPORT)
            text = simplify_kdebug_wrappers(text)

    # Cleanup multiple blank lines (max 2)
    text = re.sub(r"\n{4,}", "\n\n\n", text)

    if text != original:
        path.write_text(text, encoding="utf-8")
        stats["written"] = True
    else:
        stats["written"] = False
    return stats


def main() -> None:
    files = sorted(ROOT.rglob("*.dart"))
    results = []
    for f in files:
        rel = str(f.relative_to(ROOT)).replace("\\", "/")
        if rel in SKIP_FILES:
            continue
        # only process files that have logging markers
        content = f.read_text(encoding="utf-8", errors="ignore")
        if not re.search(
            r"\bprint\s*\(|\bdebugPrint\s*\(|developer\.log\s*\(|PrettyDioLogger",
            content,
        ):
            continue
        results.append(process_file(f))

    written = [r for r in results if r.get("written")]
    print(f"Processed {len(results)} files, modified {len(written)}")
    for r in written:
        print(
            f"  {r['file']}: removed={r.get('removed', 0)} replaced={r.get('replaced', 0)} pretty={r.get('pretty')}"
        )


if __name__ == "__main__":
    main()
