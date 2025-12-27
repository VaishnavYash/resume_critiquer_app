import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/analysis_page/widget/analysis_card.dart';
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
    return ColoredBox(
      color: const Color(0xFF0B1220),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              const SizedBox(height: 16),
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
              // Expanded(
              //   child: ListView(
              //     children: const [
              //       AnalysisCard(cardContent: ),
              //       SizedBox(height: 16),
              //       ImprovementsCard(),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white70,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // const SizedBox(width: 8),
        // Text(title, style: TextStyle(color: Colors.white70, fontSize: 13)),
        // const Text(
        //   " > Experience",
        //   style: TextStyle(color: Colors.white54, fontSize: 13),
        // ),
        // const Spacer(),
        // Container(
        //   padding: const EdgeInsets.all(6),
        //   decoration: BoxDecoration(
        //     color: const Color(0xFF121A2F),
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: const Icon(Icons.add, color: Colors.white70, size: 18),
        // ),
      ],
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
            Text(
              title,
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
        Text(
          label.title,
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
