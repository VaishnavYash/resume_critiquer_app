import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';

class ConsoleView extends StatelessWidget {
  const ConsoleView({super.key, required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: color.onSecondaryFixed,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.onSurface.withOpacity(0.6), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔹 Header (Tab)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: color.primaryFixed,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border(
                top: BorderSide(color: color.primaryFixed),
                right: BorderSide(color: color.primaryFixed),
                left: BorderSide(color: color.primaryFixed),
              ),
            ),
            child: TextWidget(
              text: title,
              style: textStyle.titleMedium?.copyWith(color: Colors.white54),
            ),
          ),
          ColoredBox(
            color: color.primaryFixed,
            child: SizedBox(width: MediaQuery.sizeOf(context).width, height: 5),
          ),
          // 🔹 Terminal body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: TextWidget(
              text: detail,
              style: textStyle.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                color: color.onPrimaryFixed,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
