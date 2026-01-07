import 'package:flutter/material.dart';

class Device {
  static double width = 0;
  static double height = 0;
  static double pixelRatio = 1;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
    pixelRatio = mediaQuery.devicePixelRatio;
  }
}
