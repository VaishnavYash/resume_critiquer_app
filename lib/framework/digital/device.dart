import 'package:flutter/material.dart';

class Device {
  static late double width;
  static late double height;
  static late double pixelRatio;
  static late BuildContext context; 
  
  static void init(BuildContext ctx) {
    final MediaQueryData mediaQuery = MediaQuery.of(ctx);
    context = ctx;
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
    pixelRatio = mediaQuery.devicePixelRatio;
  }
}
