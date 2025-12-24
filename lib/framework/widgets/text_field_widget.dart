import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/icon_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/framework/digital/sizer.dart';

enum TextFieldTheme { light, dark }

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextFieldTheme textFieldTheme;
  final double? radius;
  final String? prefixIcon;
  final double? labelSize;
  final double? prefixSize;
  final Color? bgColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? fieldTextColor;
  final Color? prefixIconColor;
  final int? maxLength;
  final Set<String> highlightWords;
  final Color highlightColor;
  final FontWeight highlightFontWeight;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.textFieldTheme,
    this.radius,
    this.hintColor,
    this.labelColor,
    this.labelSize,
    this.bgColor,
    this.prefixIcon,
    this.prefixSize,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.fieldTextColor,
    this.prefixIconColor,
    this.maxLength,
    this.highlightWords = const {},
    this.highlightColor = Colors.yellow,
    this.highlightFontWeight = FontWeight.bold,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    switch (textFieldTheme) {
      case TextFieldTheme.light:
        return _lightThemeField();
      case TextFieldTheme.dark:
        return _darkThemeField();
    }
  }

  Widget _lightThemeField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextWidget(
        text: label,
        style: TextStyle().copyWith(
          fontSize: labelSize,
          fontWeight: FontWeight.bold,
          color: labelColor,
        ),
        highlightColor: highlightColor,
        highlightWords: highlightWords,
        highlightFontWeight: highlightFontWeight,
      ),
      SizedBox(height: 10.0.dp),
      Container(
        padding: EdgeInsets.only(right: 20.0.dp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15.0.sp),
          color: bgColor,
        ),
        child: TextFormField(
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: fieldTextColor ?? Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: bgColor,
            prefixIcon:
                (prefixSize != null && prefixIcon != null)
                    ? IconWidget(path: prefixIcon!, size: prefixSize!)
                    : null,
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15.0.sp),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
        ),
      ),
    ],
  );

  Widget _darkThemeField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextWidget(
        text: label,
        style: TextStyle().copyWith(
          fontSize: labelSize,
          fontWeight: FontWeight.bold,
          color: labelColor,
        ),
      ),
      SizedBox(height: 10.0.dp),
      Container(
        padding: EdgeInsets.only(right: 20.0.dp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15.0.sp),
          color: bgColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                style: TextStyle(color: fieldTextColor),
                maxLength: maxLength,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: bgColor,
                  hintText: hintText,
                  hintStyle: TextStyle(color: hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 15.0.sp),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: validator,
              ),
            ),
            if (prefixIcon != null) _prefixIconWidget(),
          ],
        ),
      ),
    ],
  );

  Widget _prefixIconWidget() => IconWidget(
    path: prefixIcon!,
    size: prefixSize ?? 20.0.sp,
    color: prefixIconColor,
  );
}
