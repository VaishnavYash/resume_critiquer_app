import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/build_resume/build_resume.dart';
import 'package:resume_critiquer_app/build_resume/hive_code_build_resume.dart';
import 'package:resume_critiquer_app/build_resume/new_resume_pdf.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/build_resume/build_resume_model.dart';
import 'package:resume_critiquer_app/model/file_upload/file_upload_response.dart';
import 'package:resume_critiquer_app/model/other/build_resume_save.dart';
import 'package:resume_critiquer_app/model/other/save_data_response.dart';
import 'package:resume_critiquer_app/ats_score/pdf_page.dart';
import 'package:resume_critiquer_app/ats_score/widget/hiev_code.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late ColorScheme colorScheme;
  late TextTheme textStyle;

  late TabController _tabController;
  List<HistoryATSResponse>? responseList;
  List<HistoryResumeResponse>? newResumeList;

  Future<void> _loadAllResponse() async {
    responseList = HiveCode.getAllResponses();
    newResumeList = HiveBuildResume.getAllResponses();
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
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
        bottom: TabBar(
          tabs: [
            Tab(
              child: TextWidget(
                text: 'ATS Score',
                style: textStyle.bodyMedium!.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: TextWidget(
                text: 'New Resume',
                style: textStyle.bodyMedium!.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          controller: _tabController,
        ),
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
        child: TabBarView(
          controller: _tabController,
          children: [_atsHistoryUi(), _newResumeUi()],
        ),
      ),
    );
  }

  Widget _newResumeUi() =>
      newResumeList?.isEmpty ?? true
          ? Center(
            child: TextWidget(
              text: 'No Resume Made Till now !!!',
              style: textStyle.titleMedium?.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          )
          : ListView.builder(
            itemCount: newResumeList?.length,
            itemBuilder: (final context, final index) {
              final response =
                  newResumeList?[index].uploadResponse ?? BuildResumeContent();
              return Dismissible(
                key: ValueKey(newResumeList![index]),

                onDismissed: (_) {
                  final removedItem = newResumeList![index];
                  final removedIndex = index;

                  setState(() {
                    newResumeList!.removeAt(index);
                  });

                  HiveBuildResume.deleteByIndex(removedIndex);

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Item removed'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          setState(() {
                            newResumeList!.insert(removedIndex, removedItem);
                          });

                          HiveBuildResume.insertAtIndex(
                            removedIndex,
                            removedItem,
                          );
                        },
                      ),
                    ),
                  );
                },

                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: GestureDetector(
                    onTap: () async {
                      final bytes = await NewResumePdf.generatePdfContent(
                        response,
                      );
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (final context) => BuildResume(pdfBytes: bytes),
                          ),
                        );
                      }
                    },
                    child: _cardUI(
                      index,
                      newResumeList?[index].uploadName ?? '',
                      showArrow: true,
                    ),
                  ),
                ),
              );
            },
          );

  Widget _atsHistoryUi() =>
      responseList?.isEmpty ?? true
          ? Center(
            child: TextWidget(
              text: 'No Analysis Done !!!',
              style: textStyle.titleMedium?.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          )
          : ListView.builder(
            itemCount: responseList?.length,
            itemBuilder: (final context, final index) {
              final response = responseList?[index].uploadResponse;
              final atsScore = response?.atsScore ?? (0.0).toDouble();
              final resumeName = responseList?[index].uploadName ?? '';
              return Dismissible(
                key: ValueKey(responseList![index]),

                onDismissed: (_) {
                  final removedItem = responseList![index];
                  final removedIndex = index;

                  setState(() {
                    responseList!.removeAt(index);
                  });

                  HiveCode.deleteByIndex(removedIndex);

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Item removed'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          setState(() {
                            responseList!.insert(removedIndex, removedItem);
                          });

                          HiveCode.insertAtIndex(removedIndex, removedItem);
                        },
                      ),
                    ),
                  );
                },

                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: GestureDetector(
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
                    child: _cardUI(index, resumeName, atsScore: atsScore),
                  ),
                ),
              );
            },
          );

  Widget _cardUI(
    final int index,
    final String resumeName, {
    final num? atsScore,
    final bool showArrow = false,
  }) => Container(
    margin: EdgeInsets.only(top: index == 0 ? 20 : 5, bottom: 5),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: colorScheme.secondary,
      border: Border.all(color: colorScheme.onTertiary),
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: TextWidget(
            text: resumeName,
            style: textStyle.bodyMedium!.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ),

        Row(
          spacing: 10,
          children: [
            if (!showArrow)
              CircleAvatar(
                child: TextWidget(
                  text: atsScore.toString(),
                  style: textStyle.bodyLarge!.copyWith(
                    color: getColorCode(atsScore!.toDouble()),
                  ),
                ),
              ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ],
    ),
  );

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
