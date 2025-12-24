import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/theme/custom_themes/card_theme.dart';
import 'package:resume_critiquer_app/framework/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static const seedColor = Color(0xFF2563EB);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    textTheme: ThTextTheme.lightTextTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
    cardTheme: TCardTheme.lightCardTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    textTheme: ThTextTheme.darkTextTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    cardTheme: TCardTheme.darkCardTheme,
  );
}
