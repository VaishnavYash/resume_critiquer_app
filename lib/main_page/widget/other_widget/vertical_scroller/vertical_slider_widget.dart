import 'dart:math';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

typedef PageChangedCallback = void Function(double page);
typedef PageSelectedCallback = void Function(int index);

enum ALIGN { left, center, right }

class VerticalCardPager extends StatefulWidget {
  final List<CardContent> titles;
  // final List<String> extraWidget;
  final PageChangedCallback? onPageChanged;
  final PageSelectedCallback? onSelectedItem;
  final ScrollPhysics? physics;
  final int initialPage;
  final ALIGN align;
  final bool unfocusIndexShouldBeSmaller;

  const VerticalCardPager({
    super.key,
    required this.titles,
    this.onPageChanged,
    this.onSelectedItem,
    this.physics,
    this.initialPage = 0,
    this.unfocusIndexShouldBeSmaller = false,
    this.align = ALIGN.center,
  });

  @override
  State<VerticalCardPager> createState() => _VerticalCardPagerState();
}

class _VerticalCardPagerState extends State<VerticalCardPager> {
  late final PageController controller;
  double currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage.toDouble();
    controller = PageController(initialPage: widget.initialPage);

    controller.addListener(() {
      currentPage = controller.page ?? currentPage;
      widget.onPageChanged?.call(currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            /// Cards
            AnimatedBuilder(
              animation: controller,
              builder: (_, __) {
                return CardStack(
                  titles: widget.titles,
                  currentPage: currentPage,
                  viewHeight: constraints.maxHeight,
                  viewWidth: constraints.maxWidth,
                  cardWidth: MediaQuery.of(context).size.width,
                  align: widget.align,
                );
              },
            ),

            /// Gesture input only
            Positioned.fill(
              child: PageView.builder(
                controller: controller,
                scrollDirection: Axis.vertical,
                physics:
                    widget.physics ??
                    const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                itemCount: widget.titles.length,
                itemBuilder: (_, __) => const SizedBox(),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// ------------------------------------------------------------
/// CARD STACK
/// ------------------------------------------------------------

class CardStack extends StatelessWidget {
  final List<CardContent> titles;
  final double currentPage;
  final double viewHeight;
  final double viewWidth;
  final double cardWidth;
  final ALIGN align;

  const CardStack({
    super.key,
    required this.titles,
    required this.currentPage,
    required this.viewHeight,
    required this.viewWidth,
    required this.cardWidth,
    required this.align,
  });

  double get baseCardHeight => viewHeight * 0.4;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: List.generate(titles.length, (index) {
        final rawDiff = currentPage - index;

        final diff = rawDiff.clamp(-1.0, 1.0);
        final absDiff = diff.abs();

        final scale = max(0.9, 1 - absDiff * 0.1);
        final opacity =
            rawDiff.abs() >= 1.1 ? 0.0 : (1 - absDiff * 0.8).clamp(0.0, 1.0);

        final translateY = diff * baseCardHeight * 0.30; // Stack Tightness
        return Positioned(
          top: viewHeight / 4 - baseCardHeight / 4 + translateY,
          left: getStartPosition(),
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: SizedBox(
                width: cardWidth,
                child: _buildCard(context, index, diff),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _getTitleWidget(final BuildContext context, final CardContent value) {
    return TextWidget(
      text: value.title,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      alignment: TextAlign.center,
    );
  }

  Widget _getBulletPoints(
    final BuildContext context,
    final bool isFocused,
    final CardContent value,
  ) {
    final list = value.points;
    final color = Theme.of(context).colorScheme;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder:
          (final context, final index) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TextWidget(
              text: '\u2022 ${list[index]}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color:
                    isFocused ? color.onPrimaryContainer : Colors.transparent,
              ),
            ),
          ),
    );
  }

  Widget _buildCard(BuildContext context, int index, double diff) {
    final isFocused = (currentPage - index).abs() < 0.5;
    return Card(
      elevation: isFocused ? 12 : 4,
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AnimatedContainer(
          duration: Durations.medium1,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: _getTitleWidget(context, titles[index])),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 12),
                child: _getBulletPoints(context, isFocused, titles[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getStartPosition() {
    switch (align) {
      case ALIGN.left:
        return 0;
      case ALIGN.center:
        return (viewWidth - cardWidth) / 2;
      case ALIGN.right:
        return viewWidth - cardWidth;
    }
  }
}
