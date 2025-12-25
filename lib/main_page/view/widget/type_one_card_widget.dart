import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/digital/sizer.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/view/widget/vertical_slider_widget.dart';

class TypeOneCardWidget extends StatefulWidget {
  const TypeOneCardWidget({super.key, required this.data});

  final MapEntry<String, Map<String, List<String>>> data;

  @override
  State<TypeOneCardWidget> createState() => _TypeOneCardWidgetState();
}

class _TypeOneCardWidgetState extends State<TypeOneCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  final titles = <String>[];
  final preTapWidget = <Widget>[];
  final postTapWidget = <Widget>[];

  void _organizeData() {
    widget.data.value.forEach((key, value) {
      titles.add(key);
      preTapWidget.add(Card());

      final widget = ListView.builder(
        shrinkWrap: true,
        itemCount: value.length,
        itemBuilder:
            (final context, final index) => TextWidget(
              text: value[index],
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.amber),
            ),
      );

      postTapWidget.add(widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    _organizeData();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
          text: widget.data.key,
          style: Theme.of(context).textTheme.displayLarge,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.dp),
          child: Column(
            children: [
              SizedBox(
                height: 400.0.dp,
                child: VerticalCardPager(
                  width: MediaQuery.sizeOf(context).width,
                  titles: titles,
                  extraWidget: postTapWidget,
                  onPageChanged: (final page) {},
                  onSelectedItem: (final index) {},
                  initialPage: 0,
                  physics: const ClampingScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
