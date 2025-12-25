import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/view/widget/vertical_slider_widget.dart';

class CardContent {
  CardContent({required this.title, required this.points});

  final String title;
  final List<String> points;
}

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
  Widget build(BuildContext context) {
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
                height: 400,
                child: VerticalCardPager(
                  width: MediaQuery.sizeOf(context).width,
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
