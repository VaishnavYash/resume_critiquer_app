import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/analysis_page/view/section_analysis_page.dart';
import 'package:resume_critiquer_app/main_page/view/widget/analysis_card_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/api/multipart_api.dart';
import 'package:resume_critiquer_app/model/card_content.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';
import 'package:resume_critiquer_app/main_page/view/widget/ats_score_widget.dart';

class PDFUploadPage extends StatefulWidget {
  const PDFUploadPage({super.key});

  @override
  State<PDFUploadPage> createState() => _PDFUploadPageState();
}

class _PDFUploadPageState extends State<PDFUploadPage> {
  late TextTheme textTheme;
  late ColorScheme colorScheme;
  PlatformFile? file;
  FileUploadResponse response = FileUploadResponse();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      _submitResume();
      setState(() {});
    });
    super.initState();
  }

  void _submitResume() async {
    response = await MultipartApi().fileUploadMultipart(
      jobTtile: 'Sample Job Title',
    );
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceTint,
      appBar: AppBar(
        backgroundColor: colorScheme.tertiaryContainer,
        title: TextWidget(
          text: 'Resume Analysis',
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _atsScore(),
                _summaryBlock(response.summary!),
                _analysisCards(),
                // _bottomButton(),
                // SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _atsScore() {
    if (response.atsScore == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleBlock('ATS Score'),
          SizedBox(
            height: 200,
            child: AtsScoreWidget(
              atsScore: response.atsScore?.toDouble() ?? 0.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleBlock(final String title) => TextWidget(
    text: title,
    style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600),
  );

  Widget _summaryBlock(final String summary) {
    if (response.summary == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleBlock("Professional Summary"),
          const SizedBox(height: 8),
          TextWidget(
            text: summary,
            style: textTheme.labelMedium?.copyWith(height: 1.4),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _analysisCards() {
    if (response.analysis == null) return SizedBox.shrink();

    final data = <Widget>[];
    // int i = 0;
    for (var entry in response.analysis!.entries) {
      // i++;
      final list = <CardContent>[];
      for (var entryData in entry.value.entries) {
        list.add(CardContent(title: entryData.key, points: entryData.value));
      }
      data.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ExperienceAnalysisScreen(
                      title: entry.key,
                      cardContentList: list,
                    ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: AnalysisCardWidget(
              icon: Icons.work_outline,
              title: entry.key,
              cardContent: list,
            ),
          ),
        ),
      );
      // if (i == 3) break;
    }
    return Column(children: data);
  }

  // Widget _bottomButton() {
  //   return ElevatedButton(
  //     onPressed: () {},
  //     style: ElevatedButton.styleFrom(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       padding: EdgeInsets.zero,
  //     ),
  //     child: Ink(
  //       decoration: BoxDecoration(
  //         color: colorScheme.surface,
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 18),
  //         child: TextWidget(
  //           text: 'View Details',
  //           style: Theme.of(
  //             context,
  //           ).textTheme.bodySmall!.copyWith(color: colorScheme.onSurface),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
