import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/analysis_page/view/widget/analysis_card.dart';
import 'package:resume_critiquer_app/analysis_page/view/widget/glass_tabs.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class ExperienceAnalysisScreen extends StatelessWidget {
  const ExperienceAnalysisScreen({
    super.key,
    required this.title,
    required this.cardContentList,
  });

  final String title;
  final List<CardContent> cardContentList;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceTint,
      appBar: AppBar(
        backgroundColor: colorScheme.tertiaryContainer,
        title: TextWidget(
          text: 'Resume Analysis',
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _experienceTitle(context),
              GlassTabs(cardContent: cardContentList),

              const SizedBox(height: 16),
              ListView.builder(
                itemCount: cardContentList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder:
                    (final context, final index) => AnalysisCard(cardContent: cardContentList[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _experienceTitle(final BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [colorScheme.onInverseSurface, colorScheme.secondary],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.layers, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: TextWidget(
              text: title,
              style: textStyle.titleMedium!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget _tabs(final List<CardContent> content) {
//   return SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//       children: List.generate(content.length, (final index) {
//         return _TabItem(label: content[index], color: Colors.greenAccent);
//       }),
//     ),
//   );
// }

// class _TabItem extends StatelessWidget {
//   final CardContent label;
//   final Color color;

//   const _TabItem({required this.label, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     final textStyle = Theme.of(context).textTheme;
//     return Container(

//       child: Row(
//         children: [
//           Utils.getIcon(label.title.replaceAll(' ', '').toLowerCase()).icon,
//           const SizedBox(width: 4),
//           TextWidget(
//             text: label.title,
//             style: textStyle.bodySmall!.copyWith(
//               color: Colors.white70,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
