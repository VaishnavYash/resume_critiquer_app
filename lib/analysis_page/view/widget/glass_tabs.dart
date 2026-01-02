import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class GlassTabs extends StatefulWidget {
  const GlassTabs({super.key, required this.cardContent});

  final List<CardContent> cardContent;

  @override
  State<GlassTabs> createState() => _GlassTabsState();
}

class _GlassTabsState extends State<GlassTabs> {
  int selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final tabs =
        widget.cardContent.map((final value) {
          return value.title;
        }).toList();

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withAlpha(60)),
            ),
            child: Row(
              children: List.generate(tabs.length, (index) {
                final isActive = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedIndex = index);
                    _scrollToTab(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          index == 0
                              ? BorderRadius.horizontal(
                                left: Radius.circular(16),
                              )
                              : (index == tabs.length - 1
                                  ? BorderRadius.horizontal(
                                    right: Radius.circular(16),
                                  )
                                  : null),
                      gradient:
                          isActive
                              ? LinearGradient(
                                colors: [
                                  colorScheme.primary.withAlpha(180),
                                  colorScheme.primaryContainer.withAlpha(160),
                                ],
                              )
                              : null,
                    ),
                    child: TextWidget(
                      text: tabs[index],
                      alignment: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color:
                            isActive
                                ? Colors.white
                                : Colors.white.withAlpha(150),
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _scrollToTab(int index) {
    const double tabPadding = 40; // horizontal padding
    const double avgTabWidth = 110; // safe average

    final double targetOffset = (avgTabWidth + tabPadding) * index - 60;

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
