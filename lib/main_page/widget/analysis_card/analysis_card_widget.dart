import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class AnalysisCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  // final int strengths;
  // final int improvements;
  final List<CardContent> cardContent;

  const AnalysisCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.cardContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF121A2F),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
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
              color: const Color(0xFF1E2A4A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),

          const SizedBox(width: 12),

          // Title + stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
                          icon:
                              index == 0
                                  ? Icons.check_circle
                                  : Icons.warning_amber_rounded,
                          color: index == 0 ? Colors.greenAccent : Colors.amber,
                          text: "${card.points.length} ${card.title}",
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _infoChip({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
