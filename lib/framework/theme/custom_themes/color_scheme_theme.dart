import 'package:flutter/material.dart';

class TColorScheme {
  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: Color(0xFF4F46E5), // Indigo
    onPrimary: Colors.white,

    secondary: Color(0xFF06B6D4), // Cyan
    onSecondary: Colors.white,

    surface: Colors.white, // Cards
    onSurface: Color(0xFF111827), // Card text

    error: Color(0xFFDC2626),
    onError: Colors.white,
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,

    primary: Color(0xFF818CF8), // Soft Indigo
    onPrimary: Color(0xFF0F172A),

    secondary: Color(0xFF22D3EE), // Cyan
    onSecondary: Color(0xFF0F172A),

    surface: Color(0xFF0F172A), // Cards
    onSurface: Color(0xFFE5E7EB), // Card text

    error: Color(0xFFF87171),
    onError: Color(0xFF0F172A),
  );
}
