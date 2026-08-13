import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// App typefaces and emoji fallbacks.
///
/// Euclid and Poppins do not contain color-emoji glyphs. Flutter will not
/// automatically substitute the platform emoji font unless [fallback] is set
/// on the [TextStyle], so missing emojis otherwise render as tofu (□).
class AppFonts {
  AppFonts._();

  static const String euclidRegular = 'EuclidRegular';
  static const String euclidMedium = 'EuclidMedium';
  static const String euclidSmall = 'EuclidSmall';
  static const String euclidSemiBold = 'EuclidSemiBold';
  static const String poppins = 'Poppins';

  /// Family name used when the Android system color-emoji font is registered.
  static const String colorEmoji = 'NotoColorEmoji';

  /// Fonts tried after the primary family when a glyph (typically an emoji)
  /// is missing. Existing Euclid/Poppins letters, numbers, and symbols are
  /// unchanged; only missing code points fall through.
  static const List<String> fallback = [
    colorEmoji,
    'Apple Color Emoji',
    'Noto Color Emoji',
    'Segoe UI Emoji',
    'Segoe UI Symbol',
  ];

  /// [TextStyle] that keeps [fontFamily] and always includes emoji fallbacks.
  static TextStyle textStyle({
    String? fontFamily,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? letterSpacing,
    double? height,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontFamilyFallback: fallback,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      letterSpacing: letterSpacing,
      height: height,
      overflow: overflow,
    );
  }

  /// Default style for HTML bodies ([HtmlWidget] / flutter_html).
  static TextStyle htmlTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: euclidRegular,
      fontFamilyFallback: fallback,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  /// Registers the device color-emoji font on Android so [fallback] can
  /// resolve it. iOS/macOS already expose "Apple Color Emoji" by name.
  static Future<void> loadEmojiFont() async {
    if (!Platform.isAndroid) return;

    const paths = [
      '/system/fonts/NotoColorEmoji.ttf',
      '/system/fonts/SamsungColorEmoji.ttf',
      '/system/fonts/NotoColorEmojiFlags.ttf',
      '/system/fonts/NotoColorEmoji-VF.ttf',
      '/system/fonts/AndroidEmoji.ttf',
      '/product/fonts/NotoColorEmoji.ttf',
    ];

    for (final path in paths) {
      try {
        final file = File(path);
        if (!await file.exists()) continue;
        final loader = FontLoader(colorEmoji);
        loader.addFont(file.readAsBytes().then((bytes) {
          return ByteData.sublistView(bytes);
        }));
        await loader.load();
        return;
      } catch (_) {
        // Missing file, already registered (hot restart), or unsupported format.
      }
    }
  }
}
