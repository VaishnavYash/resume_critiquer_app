import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/framework/digital/sizer.dart';

enum TextFieldTheme { light, dark }

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final double? radius;
  final String? prefixIcon;
  final double? labelSize;
  final double? prefixSize;
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
    this.radius,
    this.hintColor,
    this.labelColor,
    this.labelSize,
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
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: labelSize,
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
          highlightColor: highlightColor,
          highlightWords: highlightWords,
          highlightFontWeight: highlightFontWeight,
        ),
        SizedBox(height: 10),
        TextFormField(
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: fieldTextColor ?? Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.primaryContainer,
            hintText: hintText,
            hintStyle: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: hintColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15.0.sp),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
