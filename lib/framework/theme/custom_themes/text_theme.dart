import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThTextTheme {
  static TextTheme temp = GoogleFonts.robotoMonoTextTheme();

  static TextTheme lightTextTheme = GoogleFonts.robotoMonoTextTheme(
    TextTheme(
      displayLarge: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
      displayMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF0F172A),
      ),
      displaySmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),

      headlineLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),
      headlineMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFF334155),
      ),

      titleLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF334155),
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFF475569),
      ),

      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF475569),
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF64748B),
      ),

      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2563EB),
      ),
      labelSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF94A3B8),
      ),
    ),
  );

  static TextTheme darkTextTheme = GoogleFonts.robotoMonoTextTheme(
    TextTheme().copyWith(
      displayLarge: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w700,
        color: Color(0xFFF8FAFC),
      ),
      displayMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF8FAFC),
      ),
      displaySmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE2E8F0),
      ),

      headlineLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE2E8F0),
      ),
      headlineMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFFCBD5E1),
      ),

      titleLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFFCBD5E1),
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFF94A3B8),
      ),

      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF94A3B8),
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF64748B),
      ),

      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF60A5FA),
      ),
      labelSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF64748B),
      ),
    ),
  );
}
