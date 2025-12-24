import 'package:flutter/material.dart';

class TCardTheme {
  static CardTheme lightCardTheme = CardTheme().copyWith(
    elevation: 1.5,
    shadowColor: Colors.black.withOpacity(0.08),
    color: const Color(0xFFFFFFFF),
    surfaceTintColor: Colors.transparent,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: const Color(0xFFE5E7EB), // light gray border
        width: 1,
      ),
    ),
  );

  static CardTheme darkCardTheme = CardTheme(
    elevation: 1.5,
    shadowColor: const Color.fromARGB(0, 255, 255, 255),
    color: const Color(0xFF111827), // dark slate
    surfaceTintColor: Colors.transparent,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: const Color(0xFF1F2937), // subtle border
        width: 1,
      ),
    ),
  );
}
