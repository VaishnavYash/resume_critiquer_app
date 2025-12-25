import 'package:flutter/material.dart';

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
        height: size ?? 24,
        width: size ?? 24,
        child: Image.asset(
                path,
                fit: fit ?? BoxFit.cover,
                color: color,
              ) ,
      ),
    );
  }
}
