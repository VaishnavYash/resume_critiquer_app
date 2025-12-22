import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
    this.alignment,
    this.highlightWords = const {},
    this.highlightColor = Colors.yellow,
    this.highlightFontWeight = FontWeight.bold,
    this.fontStyle,
  });

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? alignment;
  final Set<String> highlightWords;
  final Color highlightColor;
  final FontWeight highlightFontWeight;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpans = [];

    String remainingText = text;

    while (remainingText.isNotEmpty) {
      String? firstMatch;
      int matchStart = remainingText.length;

      for (String word in highlightWords) {
        final int index = remainingText.indexOf(word);
        if (index != -1 && index < matchStart) {
          firstMatch = word;
          matchStart = index;
        }
      }

      if (firstMatch == null) {
        textSpans.add(
          TextSpan(
            text: remainingText,
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: size ?? 14.0,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontStyle: fontStyle,
            ),
          ),
        );
        break;
      }

      if (matchStart > 0) {
        textSpans.add(
          TextSpan(
            text: remainingText.substring(0, matchStart),
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: size ?? 14.0,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontStyle: fontStyle,
            ),
          ),
        );
      }

      textSpans.add(
        TextSpan(
          text: firstMatch,
          style: TextStyle(
            color: highlightColor,
            fontSize: size ?? 14.0,
            fontWeight: highlightFontWeight,
            fontStyle: fontStyle,
          ),
        ),
      );

      remainingText = remainingText.substring(matchStart + firstMatch.length);
    }

    return RichText(
      textAlign: alignment ?? TextAlign.start,
      text: TextSpan(
        children: textSpans,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 14.0,
          fontStyle: fontStyle,
        ),
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
