import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

class HorizontalCarouselWidget extends StatefulWidget {
  const HorizontalCarouselWidget({super.key, required this.data});

  final MapEntry<String, Map<String, List<String>>> data;

  @override
  State<HorizontalCarouselWidget> createState() =>
      _HorizontalCarouselWidgetState();
}

class _HorizontalCarouselWidgetState extends State<HorizontalCarouselWidget> {
  PageController controller = PageController(initialPage: 0);
  late ColorScheme _colorScheme;

  var currentPage = 0;

  final cardData = <CardContent>[];
  void _organizeData() {
    widget.data.value.forEach((key, value) {
      cardData.add(CardContent(points: value, title: key));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      _organizeData();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextWidget(
            text: widget.data.key,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: PageView.builder(
            itemCount: cardData.length,
            onPageChanged: (final value) {
              currentPage = value;
              setState(() {});
            },
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: _colorScheme.secondaryContainer,
                  boxShadow: [
                    BoxShadow(
                      color: _colorScheme.onSurfaceVariant,
                      blurRadius: 5,
                      offset: Offset(1, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Column(
                      children: [
                        _getTitleWidget(context, cardData[index]),
                        SizedBox(height: 10),
                        Expanded(
                          child: _getBulletPoints(context, cardData[index]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },

            controller: controller,
            scrollDirection: Axis.horizontal,
          ),
        ),

        Align(
          alignment: Alignment.center,
          child: Card(
            color: _colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(cardData.length, (final index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor:
                          index == currentPage ? Colors.amber : Colors.black,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
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

  Widget _getBulletPoints(final BuildContext context, final CardContent value) {
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
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: color.onPrimaryContainer),
            ),
          ),
    );
  }
}
