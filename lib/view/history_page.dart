import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';
import 'package:resume_critiquer_app/model/save_data_response.dart';
import 'package:resume_critiquer_app/view/pdf_page.dart';
import 'package:resume_critiquer_app/view/widget/hiev_code.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late ColorScheme colorScheme;
  late TextTheme textStyle;

  List<HistoryResponse>? responseList;

  Future<void> _loadAllResponse() async {
    responseList = HiveCode.getAllResponses();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      _loadAllResponse();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'Previous Analysis',
          style: textStyle.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        backgroundColor: colorScheme.tertiaryContainer,
      ),
      backgroundColor: colorScheme.surfaceTint,
      body: SafeArea(
        child:
            responseList?.isEmpty ?? true
                ? Center(child: TextWidget(text: 'No History !!!'))
                : ListView.builder(
                  itemCount: responseList?.length,
                  itemBuilder: (final context, final index) {
                    final response = responseList?[index].uploadResponse;
                    final atsScore = response?.atsScore ?? (0.0).toDouble();
                    final resumeName = responseList?[index].uploadName ?? '';
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (final context) => PDFUploadPage(
                                  response: response ?? FileUploadResponse(),
                                ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 21,
                          right: 21,
                          top: index == 0 ? 20 : 5,
                          bottom: 5,
                        ),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: colorScheme.secondary,
                          border: Border.all(color: colorScheme.onTertiary),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: resumeName,
                              style: textStyle.bodyMedium!.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),

                            Row(
                              spacing: 10,
                              children: [
                                CircleAvatar(
                                  child: TextWidget(
                                    text: atsScore.toString(),
                                    style: textStyle.bodyLarge!.copyWith(
                                      color: getColorCode(atsScore.toDouble()),
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }

  Color getColorCode(double atsScore) {
    var colorCode = Colors.red;
    if (atsScore >= 80) {
      colorCode = Colors.green;
    } else if (atsScore >= 60) {
      colorCode = Colors.amber;
    }

    return colorCode;
  }
}
