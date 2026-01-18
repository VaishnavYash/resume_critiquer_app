import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/api/multipart_api.dart';
import 'package:resume_critiquer_app/ats_score/section_analysis_page.dart';
import 'package:resume_critiquer_app/ats_score/widget/analysis_card_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/other/card_content.dart';
import 'package:resume_critiquer_app/model/file_upload/file_upload_response.dart';
import 'package:resume_critiquer_app/ats_score/widget/ats_score_widget.dart';
import 'package:resume_critiquer_app/ats_score/widget/utils.dart';

class PDFUploadPage extends StatefulWidget {
  const PDFUploadPage({super.key, required this.response});

  final FileUploadResponse response;

  @override
  State<PDFUploadPage> createState() => _PDFUploadPageState();
}

class _PDFUploadPageState extends State<PDFUploadPage> {
  late TextTheme textTheme;
  late ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceTint,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSecondary,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _downloadPdfWithLoader(),
            icon: Icon(
              Icons.file_download_outlined,
              color: colorScheme.onSecondary,
            ),
          ),
        ],
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
              children: [_atsScore(), _summaryBlock(), _analysisCards()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _atsScore() {
    if (widget.response.atsScore == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleBlock('ATS Score'),
          SizedBox(
            height: 200,
            child: AtsScoreWidget(
              atsScore: widget.response.atsScore?.toDouble() ?? 0.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleBlock(final String title) => TextWidget(
    text: title,
    style: textTheme.displaySmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: colorScheme.onPrimary,
    ),
  );

  Widget _summaryBlock() {
    if (widget.response.summary == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleBlock("Professional Summary"),
          const SizedBox(height: 8),
          TextWidget(
            text: widget.response.summary ?? '',
            style: textTheme.labelMedium?.copyWith(
              height: 1.4,
              color: colorScheme.onSecondary,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _downloadButtonOnTap() async {
    final pdfBytes = await Utils.generatePdfContent(widget.response);
    await MultipartApi().downloadPdf(pdfBytes);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.primaryContainer,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: 'PDF saved successfully',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadPdfWithLoader() async {
    Utils().showBlurLoader(context);

    try {
      await _downloadButtonOnTap();
    } catch (e) {
      debugPrint('Download error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            text: 'Failed to download PDF',
            style: textTheme.bodyMedium!.copyWith(color: Colors.black),
          ),
        ),
      );
    } finally {
      if (mounted) {
        Utils().hideBlurLoader(context);
      }
    }
  }

  Widget _analysisCards() {
    if (widget.response.analysis == null) return SizedBox.shrink();
    final data = <Widget>[];
    for (var entry in widget.response.analysis!.entries) {
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
            child: AnalysisCardWidget(title: entry.key, cardContent: list),
          ),
        ),
      );
    }
    return Column(children: data);
  }

  // void _openPdf() {
  //   if (_savedPdf == null) return;

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => InAppPdfViewer(file: _savedPdf!)),
  //   );
  // }
}
