import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/digital/sizer.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.path,
    this.size,
    this.fit,
    this.color,
  });

  final String path;
  final double? size;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 24.0.dp,
        width: size ?? 24.0.dp,
        child: Image.asset(
                path,
                fit: fit ?? BoxFit.cover,
                color: color,
              ) ,
      ),
    );
  }
}
