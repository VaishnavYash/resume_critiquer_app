import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/view/widget/utils.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({super.key, required this.cardContent});

  final CardContent cardContent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _glassCard(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            title: cardContent.title,
            color: colorScheme.onSecondary,
            context: context,
          ),
          const SizedBox(height: 12),
          ListView.builder(
            itemCount: cardContent.points.length,
            shrinkWrap: true,
            itemBuilder:
                (final context, final index) =>
                    _bullet(cardContent.points[index], context: context),
          ),
          // _bottomIText( context: context,),
        ],
      ),
    );
  }

  Widget _glassCard({required Widget child, required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 5, offset: const Offset(0, 6))],
      ),
      child: child,
    );
  }

  Widget _sectionTitle({
    required String title,
    required Color color,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final iconData = Utils.getIcon(title.replaceAll(' ', '').toLowerCase());

    return Row(
      children: [
        iconData.icon,
        const SizedBox(width: 8),
        TextWidget(
          text: title,
          style: textStyle.titleMedium!.copyWith(
            color: colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _bullet(String text, {required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check, color: Colors.blue, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: TextWidget(
              text: text,
              style: textStyle.bodySmall!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _bottomIText({required BuildContext context}) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   final textStyle = Theme.of(context).textTheme;

  //   return Container(
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: colorScheme.onSecondary,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         TextWidget(
  //           text: "Why this matters",
  //           style: textStyle.bodySmall!.copyWith(
  //             color: colorScheme.onSecondary,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         SizedBox(height: 6),
  //         TextWidget(
  //           text:
  //               "Demonstrates to recruiters your ability to lead and work "
  //               "in a team environment.",
  //           style: textStyle.bodySmall!.copyWith(
  //             color: colorScheme.onSecondary,
  //             fontSize: 13,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
