import 'package:flutter/material.dart';

class ImprovementsCard extends StatelessWidget {
  const ImprovementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.warning_amber_rounded,
            title: "Areas of Improvement",
            color: Colors.amber,
          ),
          const SizedBox(height: 12),
          _bullet(
            "Add more context to the impact of academic projects on personal development.",
            icon: Icons.warning_amber_rounded,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
  Widget _glassCard({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF121A2F),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: child,
  );
}

Widget _sectionTitle({
  required IconData icon,
  required String title,
  required Color color,
}) {
  return Row(
    children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(width: 8),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget _bullet(
  String text, {
  IconData icon = Icons.check,
  Color color = Colors.greenAccent,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

}
