import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'Previous Analysis',
          style: textStyle.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        backgroundColor: colorScheme.tertiaryContainer,
      ),
      backgroundColor: colorScheme.surfaceTint,
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (final context, final index) {
            final atsScore = 65.0;
            final resumeName = 'Yash_resume';
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(
                  left: 21,
                  right: 21,
                  top: index == 0 ? 20 : 5,
                  bottom: 5,
                ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: resumeName,
                      style: textStyle.bodyMedium!.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),

                    Row(
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          child: TextWidget(
                            text: atsScore.toString(),
                            style: textStyle.bodyLarge!.copyWith(
                              color: getColorCode(atsScore),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color getColorCode(double atsScore) {
    var colorCode = Colors.red;
    if (atsScore >= 80) {
      colorCode = Colors.green;
    } else if (atsScore >= 60) {
      colorCode = Colors.amber;
    }

    return colorCode;
  }
}
