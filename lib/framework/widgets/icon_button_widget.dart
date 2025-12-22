import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/icon_widget.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.path,
    required this.size,
    this.color,
    required this.onPress,
    this.fit,
  });

  final void Function() onPress;
  final String path;
  final double size;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: IconWidget(
        path: path,
        size: size,
        color: color,
        fit: fit,
      ),
    );
  }
}
