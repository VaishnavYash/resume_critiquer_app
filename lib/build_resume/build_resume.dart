import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/build_resume/new_resume_pdf.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/build_resume/build_resume_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BuildResume extends StatefulWidget {
  const BuildResume({super.key, required this.buildResumeContent});

  final BuildResumeContent buildResumeContent;

  @override
  State<BuildResume> createState() => _BuildResumeState();
}

class _BuildResumeState extends State<BuildResume> {
  Uint8List? pdfBytes;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      _buildResume();
    });
    super.initState();
  }

  void _buildResume() async {
    pdfBytes = await NewResumePdf.generatePdfContent(widget.buildResumeContent);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    _buildResume();
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'ATS Friendly Resume',
          style: textStyle.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        backgroundColor: colorScheme.tertiaryContainer,
      ),
      body: SafeArea(
        child:
            pdfBytes == null
                ? SizedBox.shrink()
                : SfPdfViewer.memory(pdfBytes!),
      ),
    );
  }
}
