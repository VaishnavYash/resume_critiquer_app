import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/theme/custom_themes/card_theme.dart';
import 'package:resume_critiquer_app/framework/theme/custom_themes/color_scheme_theme.dart';
import 'package:resume_critiquer_app/framework/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    textTheme: ThTextTheme.lightTextTheme,
    colorScheme: TColorScheme.lightColorScheme,
    cardTheme: TCardTheme.lightCardTheme,

    scaffoldBackgroundColor: const Color(0xFFF9FAFB),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    textTheme: ThTextTheme.darkTextTheme,
    colorScheme: TColorScheme.darkColorScheme,
    scaffoldBackgroundColor: const Color(0xFF020617),
    cardTheme: TCardTheme.darkCardTheme,
  );
}
