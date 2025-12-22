import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/digital/sizer.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.radius,
    this.fit,
    this.color,
  });

  final String path;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0.0.dp),
      child: Image.asset(
        height: height,
        width: width,
        path,
        fit: fit ?? BoxFit.none,
        color: color,
        colorBlendMode: color != null ? BlendMode.srcIn : null,
      ),
    );
  }
}
