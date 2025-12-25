import 'dart:math';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';

typedef PageChangedCallback = void Function(double page);
typedef PageSelectedCallback = void Function(int index);

enum ALIGN { left, center, right }

class VerticalCardPager extends StatefulWidget {
  final List<String> titles;
  final List<Widget> extraWidget;
  final PageChangedCallback? onPageChanged;
  final PageSelectedCallback? onSelectedItem;
  final ScrollPhysics? physics;
  final int initialPage;
  final ALIGN align;
  final double width;
  final bool unfocusIndexShouldBeSmaller;

  const VerticalCardPager({
    super.key,
    required this.titles,
    required this.extraWidget,
    this.onPageChanged,
    this.onSelectedItem,
    this.physics,
    this.initialPage = 0,
    required this.width,
    this.unfocusIndexShouldBeSmaller = false,
    this.align = ALIGN.center,
  }) : assert(titles.length == extraWidget.length);

  @override
  State<VerticalCardPager> createState() => _VerticalCardPagerState();
}

class _VerticalCardPagerState extends State<VerticalCardPager> {
  late final PageController controller;
  double currentPage = 0;

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
                  extraWidget: widget.extraWidget,
                  currentPage: currentPage,
                  viewHeight: constraints.maxHeight,
                  viewWidth: constraints.maxWidth,
                  cardWidth: widget.width,
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
                itemBuilder:
                    (_, __) =>
                        SizedBox(width: MediaQuery.sizeOf(context).width),
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
  final List<String> titles;
  final List<Widget>? extraWidget;
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
    this.extraWidget,
  });

  double get baseCardHeight => viewHeight * 0.45;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: List.generate(titles.length, (index) {
        final diff = (currentPage - index).clamp(-3.0, 3.0);
        final absDiff = diff.abs();

        final scale = max(0.85, 1 - absDiff * 0.12);
        final opacity = (1 - absDiff * 0.5).clamp(0.0, 1.0);
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
                height: baseCardHeight,
                child: _buildCard(context, index, diff),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCard(BuildContext context, int index, double diff) {
    final isFocused = (currentPage - index).abs() < 0.5;
    return Card(
      elevation: isFocused ? 12 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  diff <= 0.5
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
              children: [
                TextWidget(
                  text: titles[index],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  alignment: TextAlign.center,
                ),
              ],
            ),
          ),
          if (isFocused && extraWidget != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: extraWidget![index],
            ),
        ],
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
