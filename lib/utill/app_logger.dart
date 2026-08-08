import 'package:flutter/foundation.dart';

/// Centralized app logger.
///
/// - Release / Play Store: never logs ([kDebugMode] is false).
/// - Debug: logs only when [enabled] is true.
/// - Turn off every log in the whole app by setting [enabled] = false.
class AppLogger {
  AppLogger._();

  /// Master switch. Set to `false` to silence all app logs (even in debug).
  static bool enabled = true;

  static void d(Object? message, {int? wrapWidth}) {
    if (!enabled || !kDebugMode) return;
    debugPrint(message?.toString(), wrapWidth: wrapWidth);
  }

  static void e(Object? message, {Object? error, StackTrace? stackTrace}) {
    if (!enabled || !kDebugMode) return;
    final text = message?.toString() ?? '';
    debugPrint(text.isEmpty ? 'ERROR' : 'ERROR: $text');
    if (error != null) {
      debugPrint(error.toString());
    }
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }
}
