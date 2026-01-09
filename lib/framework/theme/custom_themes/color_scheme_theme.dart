import 'package:flutter/material.dart';

class TColorScheme {
  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    inversePrimary: Color(0xFFD0BCFF),

    // Current Use
    onPrimary: Color(0xFF6482AD),
    primary: Color(0xFFdfe7fb).withAlpha(150),

    primaryContainer: Color(0xFFfaf9fe),
    onPrimaryContainer: Color(0xFF578FCA),

    onSurface: Colors.black,
    surface: Color(0xFF87A2FF),

    tertiary: Color(0xFFF5F5F5),
    onTertiary: Color(0xFFC4D7FF),

    onSecondaryContainer: Colors.black,

    secondaryContainer: Color(0xFFFBF9F1),
    tertiaryContainer: Color(0xFFF8F6E3),

    onPrimaryFixedVariant: Color(0xFFdfe7fb),
    onSecondaryFixed: Color(0xFFdfe7fb),

    secondary: Color(0xFFdfe7fb).withAlpha(180),
    onSecondary: Color(0xFF3A98B9),
    onInverseSurface: Color(0xFFdfe7fb),

    surfaceTint: Color(0xFFFFF6F6),

    error: Color(0xFF601410),
    onError: Colors.white,

    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Colors.white,
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,

    inversePrimary: Color(0xFF381E72),

    // Current Use
    primary: Color(0xFF2B334C),
    onPrimary: Color(0xFFF6EDFF),
    primaryContainer: Color(0xFF2B334C),
    onPrimaryContainer: Colors.white54,
    onSurface: Colors.white,
    surface: Colors.blueAccent,
    tertiary: Color(0xFF1E2A4A),
    onTertiary: Colors.white24,
    secondaryContainer: Color(0xFF4A5CF3),
    onSecondaryContainer: Colors.black,
    tertiaryContainer: Color(0xFF7B5CFF),
    onPrimaryFixedVariant: Color(0xFF141B34),
    onSecondaryFixed: Color(0xFF0B1020),
    secondary: Color(0xFF121A2F),
    onSecondary: Color(0xFFF6EDFF),
    onInverseSurface: Color(0xFF1B2A4A),
    surfaceTint: Color(0xFF0B1220),

    error: Color(0xFFFCEEEE),
    onError: Colors.black,
  );
}
