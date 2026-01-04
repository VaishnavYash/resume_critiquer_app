import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class GlassTabs extends StatefulWidget {
  const GlassTabs({
    super.key,
    required this.cardContent,
    required this.onTap,
    required this.selectedIndex,
  });

  final List<CardContent> cardContent;
  final void Function(int value) onTap;
  final int selectedIndex;

  @override
  State<GlassTabs> createState() => _GlassTabsState();
}

class _GlassTabsState extends State<GlassTabs> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollHint();
    });
  }

  void _scrollHint() async {
    if (!_scrollController.hasClients) return;

    const double hintOffset = 40;

    await _scrollController.animateTo(
      hintOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );

    await Future.delayed(const Duration(milliseconds: 200));

    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant GlassTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _scrollToTab(widget.selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final tabs =
        widget.cardContent.map((final value) {
          return value.title;
        }).toList();

    final tabList = List.generate(tabs.length, (index) {
      final isActive = widget.selectedIndex == index;

      return GestureDetector(
        onTap: () {
          widget.onTap(index);
          _scrollToTab(index);
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient:
                isActive
                    ? LinearGradient(
                      colors: [
                        colorScheme.primaryContainer.withAlpha(80),
                        colorScheme.primary.withAlpha(100),
                        colorScheme.primaryContainer.withAlpha(80),
                      ],
                    )
                    : null,
          ),
          child: TextWidget(
            text: tabs[index],
            alignment: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isActive ? Colors.white : Colors.white.withAlpha(150),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      );
    });

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: tabList),
      ),
    );
  }

  void _scrollToTab(int index) {
    if (!_scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      const double tabPadding = 40;
      const double avgTabWidth = 110;

      final double targetOffset = (avgTabWidth + tabPadding) * index - 60;

      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    });
  }
}
