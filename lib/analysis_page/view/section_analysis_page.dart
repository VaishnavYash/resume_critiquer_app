import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/analysis_page/view/widget/analysis_card.dart';
import 'package:resume_critiquer_app/analysis_page/view/widget/glass_tabs.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/view/widget/utils.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class ExperienceAnalysisScreen extends StatefulWidget {
  const ExperienceAnalysisScreen({
    super.key,
    required this.title,
    required this.cardContentList,
  });

  final String title;
  final List<CardContent> cardContentList;

  @override
  State<ExperienceAnalysisScreen> createState() =>
      _ExperienceAnalysisScreenState();
}

class _ExperienceAnalysisScreenState extends State<ExperienceAnalysisScreen> {
  int selectedIndex = 0;
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
              GlassTabs(
                cardContent: widget.cardContentList,
                onTap: (final index) {
                  setState(() => selectedIndex = index);
                },
                selectedIndex: selectedIndex,
              ),

              const SizedBox(height: 16),
              ListView.builder(
                itemCount: widget.cardContentList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder:
                    (final context, final index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnalysisCard(
                        cardContent: widget.cardContentList[index],
                        selectedIndex: selectedIndex,
                        index: index,
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
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [colorScheme.secondary, colorScheme.onInverseSurface],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.surfaceTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Utils.getHeadingIcon(label: widget.title),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: TextWidget(
              text: widget.title,
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
