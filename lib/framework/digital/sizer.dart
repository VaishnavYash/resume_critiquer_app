import 'package:resume_critiquer_app/framework/digital/device.dart';

extension Sizer on double {
  double get sp {
    if (Device.width == 0) return this;
    const baseWidth = 390.0;
    return this * (Device.width / baseWidth);
  }
}
