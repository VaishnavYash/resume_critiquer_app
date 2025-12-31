import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/digital/sizer.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';

class ConsoleView extends StatelessWidget {
  const ConsoleView({super.key, required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      elevation: 10,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: color.onSurface,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          _row(title, textStyle, color),
          ColoredBox(
            color: Colors.white,
            child: SizedBox(height: 1, width: double.infinity),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),
              color: color.secondaryFixed,
            ),

            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: TextWidget(
              text: detail,
              style: textStyle.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                color: color.onPrimaryFixed,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(
    final String title,
    final TextTheme textStyle,
    final ColorScheme color,
  ) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color.primaryFixed,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(9),
        topRight: Radius.circular(9),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.terminal, color: Colors.white, size: 22.0.sp),
        const SizedBox(width: 8),
        TextWidget(
          text: title,
          style: textStyle.titleLarge?.copyWith(color: Colors.white),
        ),
        const Spacer(),
        CircleAvatar(radius: 8, backgroundColor: Colors.yellow),
      ],
    ),
  );
}
