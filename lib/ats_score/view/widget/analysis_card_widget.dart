import 'dart:math';

import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/ats_score/view/widget/utils.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

import '../../../framework/widgets/text_widget.dart';

class AnalysisCardWidget extends StatelessWidget {
  final String title;
  final List<CardContent> cardContent;

  const AnalysisCardWidget({
    super.key,
    required this.title,
    required this.cardContent,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSecondaryFixed,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.tertiary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Utils.getHeadingIcon(label: title),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  style: textStyle.bodyMedium!.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),

                const SizedBox(height: 6),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(min(cardContent.length, 2), (
                      final index,
                    ) {
                      final card = cardContent[index];
                      return Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: _infoChip(
                          context: context,
                          text: card.title,
                          count: card.points.data?.length ?? 0,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _infoChip({
    required String text,
    required BuildContext context,
    required int count,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final searchString = text.replaceAll(' ', '').toLowerCase();
    final iconData = Utils.getIcon(label: searchString);

    return Row(
      children: [
        iconData.icon,
        const SizedBox(width: 5),
        TextWidget(
          text: '$count $text',
          highlightWords: {count.toString()},
          highlightColor:
              iconData.color == Colors.greenAccent
                  ? iconData.color
                  : colorScheme.onSurface,
          highlightFontWeight: FontWeight.bold,
          style: textStyle.labelSmall!.copyWith(
            color: colorScheme.onSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
