import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/analysis_page/view/section_analysis_page.dart';
import 'package:resume_critiquer_app/main_page/widget/analysis_card/analysis_card_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/api/multipart_api.dart';
import 'package:resume_critiquer_app/model/card_content.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';
import 'package:resume_critiquer_app/main_page/widget/other_widget/score_gauge/ats_score_widget.dart';

class PDFUploadPage extends StatefulWidget {
  const PDFUploadPage({super.key});

  @override
  State<PDFUploadPage> createState() => _PDFUploadPageState();
}

class _PDFUploadPageState extends State<PDFUploadPage> {
  late TextTheme textTheme;
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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.tertiaryContainer,
        title: TextWidget(text: 'Resume Analysis', style: textTheme.titleLarge),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.onPrimaryFixedVariant,
                  colorScheme.onSecondaryFixed,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _atsScore(),
                _summaryBlock(response.summary!),
                _analysisCards(),
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
          TextWidget(text: 'ATS Score', style: textTheme.displayMedium!),
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

  Widget _summaryBlock(final String summary) {
    if (response.summary == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "Professional Summary",
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
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
    for (var entry in response.analysis!.entries) {
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
    }
    return Column(children: data);
  }
}



                // ConsoleView(
                //   title: 'Summary',
                //   detail:response.summary ?? '',
                // ),

                // if (response.analysis?.isNotEmpty ?? false)
                //   TypeOneCardWidget(data: response.analysis!.entries.first),

                // if (response.analysis?.isNotEmpty ?? false)
                //   HorizontalCarouselWidget(data: response.analysis!.entries.first),

                // ListView.builder(
                //   itemCount: 30,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, value) {
                //     return TextWidget(
                //       text: 'PDF Upload Page',
                //       style: textTheme.displayMedium?.copyWith(color: Colors.yellow),
                //     );
                //   },
                // ),