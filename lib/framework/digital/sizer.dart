import 'package:flutter/material.dart';
import 'device.dart';
extension Sizer on double {
  double get sp {
    final mediaQuery = MediaQuery.of(Device.context);

    const baseWidth = 390.0; // Design reference
    final scaleFactor = Device.width / baseWidth;

    return mediaQuery.textScaler.scale(this * scaleFactor);
  }
}
