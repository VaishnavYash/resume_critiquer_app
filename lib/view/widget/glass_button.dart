import 'dart:ui';
import 'package:flutter/material.dart';

class GlassButton extends StatelessWidget {
  final Widget textWidget;
  final VoidCallback onTap;
  final double borderRadius;
  final List<Color> colorsList;
  final double blur;
  final EdgeInsets? padding;

  const GlassButton({
    super.key,
    required this.textWidget,
    required this.onTap,
    required this.colorsList,
    this.borderRadius = 16,
    this.blur = 20,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            splashColor: colorScheme.primaryContainer.withAlpha(50),
            highlightColor: colorScheme.onPrimaryContainer.withAlpha(50),
            onTap: onTap,
            child: Ink(
              padding: padding ?? EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colorsList,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: textWidget,
            ),
          ),
        ),
      ),
    );
  }
}
