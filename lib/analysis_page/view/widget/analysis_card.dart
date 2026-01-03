import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/view/widget/utils.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({
    super.key,
    required this.cardContent,
    required this.selectedIndex,
    required this.index,
  });

  final CardContent cardContent;
  final int selectedIndex;
  final int index;

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
          if (selectedIndex == index) const SizedBox(height: 12),
          _showContentList(),
          if (selectedIndex == index) const SizedBox(height: 10),
          _bottomIText(context, label: cardContent.points.whyThisMatter),
        ],
      ),
    );
  }

  Widget _showContentList() => AnimatedSize(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutCubic,
    child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child:
          selectedIndex == index
              ? ListView.builder(
                key: const ValueKey('content'),
                itemCount: cardContent.points.data?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (context, i) => _bullet(
                      cardContent.points.data?[i] ?? '',
                      context: context,
                    ),
              )
              : const SizedBox.shrink(key: ValueKey('empty')),
    ),
  );

  Widget _glassCard({required Widget child, required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: Durations.extralong1,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            selectedIndex == index
                ? colorScheme.secondary
                : colorScheme.primaryContainer.withAlpha(100),

        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: child,
    );
  }

  Widget _sectionTitle({
    required String title,
    required Color color,
    required BuildContext context,
  }) {
    bool isSlected = selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final iconData = Utils.getIcon(
      label: title.replaceAll(' ', '').toLowerCase(),
      size: isSlected ? 20 : 24,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isSlected ? 0 : 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconData.icon,
          const SizedBox(width: 8),
          Flexible(
            child: TextWidget(
              text: title,
              style: textStyle.titleMedium!.copyWith(
                fontSize: isSlected ? null : 16,
                color: colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
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

  Widget _bottomIText(BuildContext context, {String? label}) {
    if (selectedIndex != index || label == null) return SizedBox.shrink();
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withAlpha(100),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 5, offset: const Offset(0, 0))],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "Why this matters",
            style: textStyle.labelLarge!.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(height: 6),
          TextWidget(
            text: label,
            style: textStyle.labelMedium!.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
