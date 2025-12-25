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
  late ColorScheme _color;
  @override
  void initState() {
    super.initState();
  }

  final titles = <Widget>[];
  final postTapWidget = <Widget>[];

  TextWidget _getTitleWidget(final String value) => TextWidget(
    text: value,
    style: Theme.of(context).textTheme.displaySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: _color.primary,
    ),
    alignment: TextAlign.center,
  );

  void _organizeData() {
    widget.data.value.forEach((key, value) {
      titles.add(_getTitleWidget(key));
      final widget = ListView.builder(
        shrinkWrap: true,
        itemCount: value.length,
        itemBuilder:
            (final context, final index) => TextWidget(
              text: value[index],
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: _color.onSurface),
            ),
      );

      postTapWidget.add(widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    _color = Theme.of(context).colorScheme;
    _organizeData();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.dp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: widget.data.key,
            style: Theme.of(context).textTheme.displayMedium,
          ),

          Column(
            children: [
              SizedBox(
                height: 400.0.dp,
                child: VerticalCardPager(
                  width: MediaQuery.sizeOf(context).width,
                  titles: titles,
                  extraWidget: postTapWidget,
                  initialPage: 0,
                  physics: const ClampingScrollPhysics(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
