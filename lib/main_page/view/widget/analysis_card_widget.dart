import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/main_page/view/widget/utils.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

import '../../../framework/widgets/text_widget.dart';

class AnalysisCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<CardContent> cardContent;

  const AnalysisCardWidget({
    super.key,
    required this.icon,
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
          // Left Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.tertiary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: colorScheme.onSecondary, size: 20),
          ),

          const SizedBox(width: 12),

          // Title + stats
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
                    children: List.generate(cardContent.length, (final index) {
                      final card = cardContent[index];
                      return Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: _infoChip(
                          context: context,
                          icon:
                              index == 0
                                  ? Icons.check_circle
                                  : Icons.warning_amber_rounded,
                          // color:
                          //     index == 0
                          //         ? colorScheme.error
                          //         : colorScheme.onError,
                          text: "${card.points.length} ${card.title}",
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            //  color: colorScheme.white54
          ),
        ],
      ),
    );
  }

  Widget _infoChip({
    required IconData icon,
    required String text,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Row(
      children: [
        Utils.getIcon(text.replaceAll(' ', '').toLowerCase()),
        const SizedBox(width: 4),
        TextWidget(
          text: text,
          style: textStyle.bodySmall!.copyWith(color: colorScheme.onSecondary),
        ),
      ],
    );
  }
}
