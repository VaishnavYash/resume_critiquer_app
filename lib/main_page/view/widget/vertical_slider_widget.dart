import 'dart:math';

import 'package:flutter/material.dart';

typedef PageChangedCallback = void Function(double? page);
typedef PageSelectedCallback = void Function(int index);

enum ALIGN { left, center, right }

class VerticalCardPager extends StatefulWidget {
  final List<String> titles;
  final List<Widget> images;
  final List<Widget>? extraWidget;
  final PageChangedCallback? onPageChanged;
  final PageSelectedCallback? onSelectedItem;
  final ScrollPhysics? physics;
  // final TextStyle? textStyle;
  final int initialPage;
  final ALIGN align;

  final double width;

  /// ### IMPORTANT:
  /// If true, the **top and bottom Item** `size` will be reduced.
  /// ```dart
  ///    unfocusIndexShouldBeSmaller : true,
  /// ```
  final bool unfocusIndexShouldBeSmaller;

  const VerticalCardPager({
    super.key,
    required this.titles,
    required this.images,
    required this.extraWidget,
    this.onPageChanged,
    // this.textStyle,
    this.initialPage = 2,
    this.onSelectedItem,
    this.physics,
    required this.width,
    this.unfocusIndexShouldBeSmaller = false,
    this.align = ALIGN.center,
  }) : assert(titles.length == images.length, 'Yeehhhh Nahi Chala ');

  @override
  State<VerticalCardPager> createState() => _VerticalCardPagerState();
}

class _VerticalCardPagerState extends State<VerticalCardPager> {
  bool isScrolling = false;
  // late double currentPosition;
  late PageController controller;

  @override
  void initState() {
    super.initState();

    // currentPosition = widget.initialPage.toDouble();
    controller = PageController(initialPage: widget.initialPage);

    // controller.addListener(() {
    //   setState(() {
    //     currentPosition = controller.page ?? 0;

    //     if (widget.onPageChanged != null) {
    //       Future(() => widget.onPageChanged!(currentPosition));
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder:
        (context, constraints) => GestureDetector(
          onVerticalDragStart: (_) => isScrolling = true,
          onVerticalDragEnd: (_) => isScrolling = false,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  final currentPosition =
                      controller.hasClients
                          ? (controller.page ?? widget.initialPage.toDouble())
                          : widget.initialPage.toDouble();

                  // Optional callback (safe now)
                  widget.onPageChanged?.call(currentPosition);

                  return CardControllerWidget(
                    width: widget.width,
                    titles: widget.titles,
                    images: widget.images,
                    extraWidget: widget.extraWidget,
                    unfocusIndexShouldBeSmaller:
                        widget.unfocusIndexShouldBeSmaller,
                    currentPostion: currentPosition,
                    cardViewPagerHeight: constraints.maxHeight,
                    cardViewPagerWidth: constraints.maxWidth,
                    align: widget.align,
                  );
                },
              ),

              // PageView ONLY for scroll input
              Positioned.fill(
                child: PageView.builder(
                  controller: controller,
                  physics: widget.physics,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.images.length,
                  itemBuilder: (_, __) => const SizedBox(),
                ),
              ),
            ],
          ),
        ),
  );
}

class CardControllerWidget extends StatelessWidget {
  final double? currentPostion;
  final double cardMaxWidth;
  final double cardMaxHeight;
  final double cardViewPagerHeight;
  final double? cardViewPagerWidth;
  // final TextStyle? textStyle;
  final ALIGN align;
  final double width;
  final bool unfocusIndexShouldBeSmaller;
  final List<String>? titles;
  final List<Widget>? images;
  final List<Widget>? extraWidget;

  const CardControllerWidget({
    super.key,
    this.titles,
    this.images,
    this.extraWidget,
    this.cardViewPagerWidth,
    required this.cardViewPagerHeight,
    this.currentPostion,
    this.unfocusIndexShouldBeSmaller = false,
    required this.align,
    required this.width,
    // this.textStyle,
  }) : cardMaxHeight = cardViewPagerHeight * (1 / 2),
       cardMaxWidth = cardViewPagerHeight * (1 / 2);

  @override
  Widget build(final BuildContext context) {
    final cardList = <Widget>[];

    for (var i = 0; i < images!.length; i++) {
      final cardWidth = width;
      final cardHeight = getCardHeight(i);
      final cardTop = getTop(cardHeight, cardViewPagerHeight, i);

      final textWidget = Align(
        child: Text(
          titles![i].toString(),
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontSize: getFontSize(i)),
          textAlign: TextAlign.start,
        ),
      );

      final Widget card = Positioned.directional(
        textDirection: TextDirection.ltr,
        top: cardTop,
        start: getStartPositon(cardWidth),
        child: Opacity(
          opacity: getOpacity(i),
          child: SizedBox(
            width: cardWidth,
            height: currentPostion == i ? null : cardHeight,
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: images![i]),

                if (currentPostion != i) textWidget,
                if (currentPostion == i)
                  Column(children: [textWidget, extraWidget![i]]),
              ],
            ),
          ),
        ),
      );

      cardList.add(card);
    }

    return Stack(children: cardList);
  }

  double getOpacity(final int i) {
    final diff = currentPostion! - i;

    if (diff >= -2 && diff <= 2) {
      return 1.0;
    } else if (diff > -3 && diff < -2) {
      return 3 - diff.abs();
    } else if (diff > 2 && diff < 3) {
      return 3 - diff.abs();
    } else {
      return 0;
    }
  }

  double getTop(final double cardHeight, final double viewHeight, final int i) {
    final diff = currentPostion! - i;
    final diffAbs = diff.abs();

    final basePosition = (viewHeight / 2) - (cardHeight / 2);

    if (diffAbs == 0) return basePosition;

    // Main Focus
    if (diffAbs > 0.0 && diffAbs <= 1.0) {
      if (diff >= 0) {
        return basePosition - (cardMaxHeight * (6 / 9)) * diffAbs;
      } else {
        return basePosition + (cardMaxHeight * (6 / 9)) * diffAbs;
      }
    }
    // Second Focus
    else if (diffAbs > 1.0 && diffAbs < 2.0) {
      if (diff >= 0) {
        return basePosition -
            (cardMaxHeight * (6 / 9)) -
            cardMaxHeight * (2 / 9) * (diffAbs - diffAbs.floor()).abs();
      } else {
        return basePosition +
            (cardMaxHeight * (6 / 9)) +
            cardMaxHeight * (2 / 9) * (diffAbs - diffAbs.floor()).abs();
      }
    }
    // Third Focus
    else {
      if (diff >= 0) {
        return basePosition - cardMaxHeight * (8 / 9);
      } else {
        return basePosition + cardMaxHeight * (8 / 9);
      }
    }
  }

  double getCardHeight(final int index) {
    final diff = (currentPostion! - index).abs();
    final fractional = diff - diff.floor();
    final percentHeight = cardMaxHeight * (3 / 5);

    // Focus
    if (diff >= 0.0 && diff < 1.0) {
      return cardMaxHeight - percentHeight * fractional;
    }
    // second Focus
    else if (diff >= 1.0 && diff < 2.0) {
      return cardMaxHeight - percentHeight - 10 * fractional;
    }
    // Third Focus
    else {
      final height = cardMaxHeight - percentHeight - 5 * fractional;
      return height > 0 ? height : 0;
    }
  }

  double getFontSize(final int index) {
    var diffAbs = (currentPostion! - index).abs();
    diffAbs = num.parse(diffAbs.toStringAsFixed(2)) as double;

    const maxFontSize = 50;

    // Main Focus
    if (diffAbs >= 0.0 && diffAbs < 1.0) {
      if (diffAbs < 0.02) {
        diffAbs = 0;
      }
      return maxFontSize - 25 * (diffAbs - diffAbs.floor());
    }
    // Second Focus
    else if (diffAbs >= 1.0 && diffAbs < 2.0) {
      return maxFontSize - 25 - 5 * (diffAbs - diffAbs.floor());
    }
    // Third Focus
    else {
      final fontSize = maxFontSize - 30 - 15 * (diffAbs - diffAbs.floor());
      return fontSize > 0 ? fontSize : 0;
    }
  }

  double getStartPositon(final double cardWidth) {
    var position = 0.0;

    switch (align) {
      case ALIGN.left:
        position = 0;
        break;
      case ALIGN.center:
        position = (cardViewPagerWidth! / 2) - (cardWidth / 2);
        break;
      case ALIGN.right:
        position = cardViewPagerWidth! - cardWidth;
        break;
    }

    return position;
  }
}
