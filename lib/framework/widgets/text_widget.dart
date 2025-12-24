import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.style,
    this.alignment,
    this.highlightWords = const {},
    this.highlightColor = Colors.yellow,
    this.highlightFontWeight = FontWeight.bold,
  });

  final String text;
  final TextAlign? alignment;
  final Set<String> highlightWords;
  final Color highlightColor;
  final FontWeight highlightFontWeight;
  final TextStyle? style;

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
        textSpans.add(TextSpan(text: remainingText, style: style));
        break;
      }

      if (matchStart > 0) {
        textSpans.add(
          TextSpan(text: remainingText.substring(0, matchStart), style: style),
        );
      }

      textSpans.add(
        TextSpan(
          text: firstMatch,
          style: style?.copyWith(
            color: highlightColor,
            fontWeight: highlightFontWeight,
          ),
        ),
      );

      remainingText = remainingText.substring(matchStart + firstMatch.length);
    }

    return RichText(
      textAlign: alignment ?? TextAlign.start,
      text: TextSpan(children: textSpans, style: style),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
