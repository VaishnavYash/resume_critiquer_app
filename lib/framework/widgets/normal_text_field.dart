import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';

enum NormalTextFieldType { light, dark, darkUnderline }

class NormalTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Color? bgColor;
  final Color? fieldTextColor;
  final bool? isfilled;
  final Color? hintTextColor;
  final double? hintTextSize;
  final TextInputType? keyboardType;
  final String hintText;
  final String? label;
  final NormalTextFieldType textFieldTheme;
  final String? Function(String?)? validator;

  const NormalTextFieldWidget({
    super.key,
    required this.hintText,
    this.hintTextColor,
    this.hintTextSize,
    this.controller,
    this.bgColor,
    this.keyboardType,
    this.isfilled = false,
    this.label,
    this.fieldTextColor,
    this.textFieldTheme = NormalTextFieldType.light,
    this.validator,
  });

  @override
  State<NormalTextFieldWidget> createState() => _NormalTextFieldWidgetState();
}

class _NormalTextFieldWidgetState extends State<NormalTextFieldWidget> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      builder: (FormFieldState<String> field) {
        return _buildTextField(field);
      },
    );
  }

  Widget _buildTextField(FormFieldState<String> field) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: widget.fieldTextColor),
      decoration: InputDecoration(
        filled: widget.isfilled,
        fillColor: widget.bgColor,
        label:
            widget.label != null
                ? TextWidget(
                  text: widget.label!,
                  style: TextStyle().copyWith(color: widget.fieldTextColor),
                )
                : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintTextColor,
          fontSize: widget.hintTextSize,
        ),
        border: _getBorderStyle(),
        errorText: field.errorText,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
      ),
      onChanged: (value) {
        field.didChange(value);
      },
    );
  }

  InputBorder _getBorderStyle() {
    switch (widget.textFieldTheme) {
      case NormalTextFieldType.light:
        return OutlineInputBorder();
      case NormalTextFieldType.dark:
        return UnderlineInputBorder();
      case NormalTextFieldType.darkUnderline:
        return const UnderlineInputBorder();
    }
  }
}
