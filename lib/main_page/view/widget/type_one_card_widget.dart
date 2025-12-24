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
              style: Theme.of(context).textTheme.titleSmall,
            ),
      );

      postTapWidget.add(widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    _organizeData();
    _organizeData();
    return Column(
      children: [
        TextWidget(
          text: widget.data.key,
          style: Theme.of(context).textTheme.displayLarge,
        ),

        SizedBox(
          height: 300.0.dp,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.dp),
            child: VerticalCardPager(
              width: MediaQuery.sizeOf(context).width,
              titles: titles,
              images: preTapWidget,
              extraWidget: postTapWidget,
              onPageChanged: (final page) {},
              onSelectedItem: (final index) {},
              initialPage: 0,
              physics: const ClampingScrollPhysics(),
            ),
          ),
        ),
        
        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: titles.length,
        //   itemBuilder: (context, index) {
        //     return InkWell(
        //       onTap: () {},
        //       child: AnimatedContainer(
        //         // height: isTap ? 600 : 200,
        //         duration: Duration(milliseconds: 500),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10.0.dp),
        //         ),

        //         child: Column(
        //           children: [
        //             TextWidget(
        //               text: titles[index],
        //               style: Theme.of(context).textTheme.displaySmall,
        //             ),
        //             // if (isTap)
        //             // ListView.builder(
        //             //   shrinkWrap: true,
        //             //   itemCount:
        //             //       widget.data.value[list[index]]?.length ?? 0,
        //             //   itemBuilder:
        //             //       (context, ind) => TextWidget(
        //             //         text:
        //             //             widget.data.value[list[index]]?[ind] ?? '',
        //             //         style: Theme.of(context).textTheme.bodySmall,
        //             //       ),
        //             // ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
