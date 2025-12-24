import 'package:flutter/material.dart';

class CustomColors {
  static const Color darkGrey = Color.fromRGBO(18, 18, 18, 1);
  static const Color darkPrimary = Color.fromRGBO(30, 41, 59, 1);
  static const Color primaryPurple200 = Color.fromRGBO(30, 41, 59, 1);
  static const Color primaryPurple700 = Color.fromRGBO(30, 41, 59, 1);
}

Color getHexColor(String colorCode) {
  return Color(int.parse(colorCode.substring(1, 7), radix: 16) + 0xFF000000);
}
