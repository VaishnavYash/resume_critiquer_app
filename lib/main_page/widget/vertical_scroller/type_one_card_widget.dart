import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/widget/vertical_scroller/vertical_slider_widget.dart';
import 'package:resume_critiquer_app/model/card_content.dart';

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

  final titles = <CardContent>[];
  void _organizeData() {
    widget.data.value.forEach((key, value) {
      titles.add(CardContent(points: value, title: key));
    });
  }

  @override
  void dispose() {
    titles.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titles.clear();
    _organizeData();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
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
                height: 360,
                child: VerticalCardPager(
                  titles: titles,
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
