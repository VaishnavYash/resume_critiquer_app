import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/constants/enums.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    super.key,
    required this.label,
    required this.onPress,
    this.onLongPress,
    this.icon,
    this.buttonType = ButtonType.normal,
    this.bgColor,
    this.iconColor,
    this.padding,
    this.radius,
  });

  final void Function() onPress;
  final Widget? icon;
  final Widget label;
  final Color? bgColor;
  final Color? iconColor;
  final double? padding;
  final ButtonType buttonType;
  final double? radius;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.normal:
        return _buildNormalButton();
      case ButtonType.outlined:
        return _buildOutlinedButton();
      case ButtonType.text:
        return _buildTextButton();
      case ButtonType.buttonWithIcon:
        return _buildButtonWithIcon();
      case ButtonType.backIconButton:
        return _buildBackIcon();
      case ButtonType.customButton:
        return _buildCustomButton();
    }
  }

  Widget _buildBackIcon() {
    return ElevatedButton.icon(
      label: label,
      onPressed: onPress,
      icon: icon,
      style: ElevatedButton.styleFrom(
        iconColor: iconColor,
        backgroundColor: bgColor,
      ),
      onLongPress: onLongPress,
    );
  }

  Widget _buildButtonWithIcon() {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(backgroundColor: bgColor),
      onLongPress: onLongPress,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [label, Visibility(visible: icon != null, child: icon!)],
        ),
      ),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton(
      onPressed: onPress,
      onLongPress: onLongPress,
      style: OutlinedButton.styleFrom(shadowColor: bgColor),
      child: label,
    );
  }

  Widget _buildNormalButton() {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        iconColor: iconColor,
        backgroundColor: bgColor,
      ),
      onLongPress: onLongPress,
      child: label,
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: onPress,
      onLongPress: onLongPress,
      child: label,
    );
  }

  Widget _buildCustomButton() {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(padding ?? 0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: Center(child: label),
      ),
    );
  }
}
