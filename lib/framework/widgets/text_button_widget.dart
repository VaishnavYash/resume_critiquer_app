import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';

class TextButtonWidget extends StatefulWidget {
  const TextButtonWidget({super.key, this.onPress});

  final void Function()? onPress;

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: widget.onPress,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: TextWidget(
          text: 'Build Your Own Resume',
          style: textStyle.bodyMedium!.copyWith(
            color: colorScheme.onSurface,
            decoration:
                _isPressed ? TextDecoration.underline : TextDecoration.none,
            decorationColor: Colors.white,
            decorationThickness: 2.0,
          ),
        ),
      ),
    );
  }
}
