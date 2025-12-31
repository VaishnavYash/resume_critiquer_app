import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/analysis_page/widget/analysis_card.dart';
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
  // backgroundColor: const Color(0xFF0B1220),

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: colorScheme.tertiaryContainer,
        title: TextWidget(text: 'Resume Analysis', style: textTheme.titleSmall),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _experienceTitle(context),
              const SizedBox(height: 12),
              _tabs(cardContentList),
              const SizedBox(height: 16),
              ListView.builder(
                itemCount: cardContentList.length,
                shrinkWrap: true,
                itemBuilder:
                    (final context, final index) => Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: AnalysisCard(
                        iconPath: Icons.import_contacts,
                        cardContent: cardContentList[index],
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _experienceTitle(final BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [const Color(0xFF1B2A4A), const Color(0xFF121A2F)],
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2A4A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.layers, color: Colors.white),
            ),
            const SizedBox(width: 10),
            TextWidget(
              text: title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _tabs(final List<CardContent> content) {
  return Row(
    children: List.generate(content.length, (final index) {
      return _TabItem(
        icon: Icons.check_circle,
        label: content[index],
        color: Colors.greenAccent,
      );
    }),

    //  const [
    //   _TabItem(
    //     icon: Icons.check_circle,
    //     label: "Strengths",
    //     data:
    //     color: Colors.greenAccent,
    //   ),
    //   SizedBox(width: 12),
    //   _TabItem(
    //     icon: Icons.warning_amber_rounded,
    //     label: "Areas of Improvement",
    //     color: Colors.amber,
    //   ),
    //   // Spacer(),
    //   // _TabItem(
    //   //   icon: Icons.visibility,
    //   //   label: "View Details",
    //   //   color: Colors.white54,
    //   // ),
    // ],
  );
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final CardContent label;
  final Color color;

  const _TabItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        TextWidget(
          text: label.title,
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
