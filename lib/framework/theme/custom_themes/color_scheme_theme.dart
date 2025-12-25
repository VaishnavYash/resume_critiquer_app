import 'package:flutter/material.dart';

class TColorScheme {
  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    inversePrimary: Color(0xFFD0BCFF),

    primary: Color(0xFF381E72),
    onPrimary: Color(0xFFFFFFFF),

    primaryContainer: Color(0xFF4F378B),
    onPrimaryContainer: Color(0xFFFFFFFF),

    secondary: Color(0xFF332D41),
    onSecondary: Colors.white,

    secondaryContainer: Color(0xFF4A4458),
    onSecondaryContainer: Colors.white,

    tertiary: Color(0xFF492532),
    onTertiary: Colors.white,

    tertiaryContainer: Color(0xFF633B48),
    onTertiaryContainer: Colors.white,

    error: Color(0xFF601410),
    onError: Colors.white,

    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Colors.white,

    surface: Colors.white,
    onSurface: Colors.black,

    surfaceContainerHighest: Color(0xFFE6E0E9),
    surfaceContainerHigh: Color(0xFFECE6F0),
    surfaceContainer: Color(0xFFF3EDF7),
    surfaceContainerLow: Color(0xFFF7F2FA),
    surfaceContainerLowest: Colors.white,
    inverseSurface: Color(0xFF322F35),
    onInverseSurface: Colors.white,
    surfaceTint: Color(0xFF381E72),

    outline: Color(0xFF322F37),
    outlineVariant: Color(0xFF49454F),
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,

    inversePrimary: Color(0xFF381E72),

    primary: Color(0xFFF6EDFF),
    onPrimary: Color(0xFF000000),

    primaryContainer: Color(0xFFD0BCFF),
    onPrimaryContainer: Color(0xFF000000),

    secondary: Color(0xFFF6EDFF),
    onSecondary: Colors.black,

    secondaryContainer: Color(0xFFCCC2DC),
    onSecondaryContainer: Colors.black,

    tertiary: Color(0xFFFFECF1),
    onTertiary: Colors.black,

    tertiaryContainer: Color(0xFFEFB8C8),
    onTertiaryContainer: Colors.black,

    error: Color(0xFFFCEEEE),
    onError: Colors.black,

    errorContainer: Color(0xFFF2B8B5),
    onErrorContainer: Colors.black,

    surface: Color(0xFF141218),
    onSurface: Colors.white,
    surfaceContainerHighest: Color(0xFF36343B),
    surfaceContainerHigh: Color(0xFF2B2930),
    surfaceContainer: Color(0xFF211F26),
    surfaceContainerLow: Color(0xFF1D1B20),
    surfaceContainerLowest: Color(0xFF0F0D13),
    inverseSurface: Color(0xFFE6E0E9),
    onInverseSurface: Color(0xFF000000),
    surfaceTint: Color(0xFFF6EDFF),

    outline: Color(0xFFF5EEFA),
    outlineVariant: Color(0xFFCAC4D0),
  );
}
