import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'device.dart';

extension Sizer on double {
  /// Calculates the sp (Scalable Pixel) depending on the device's pixel
  /// density and aspect ratio
  double get sp => MediaQuery.of(Device.context).textScaler.scale(
        (math.min(Device.width / 390.0, Device.height / 844.0) /
                (Device.width / 390.0)) *
            this,
      );

  /// Calculates the material dp (Pixel Density)
  /// (https://material.io/design/layout/pixel-density.html#pixel-density-on-android))
  double get dp => (math.log(Device.width * Device.height * Device.pixelRatio) /
          math.log(2) /
          20 *
          this)
      .abs();
}
