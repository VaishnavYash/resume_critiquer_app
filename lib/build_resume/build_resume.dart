import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/api/build_resume_api.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BuildResume extends StatelessWidget {
  const BuildResume({super.key, required this.pdfBytes});

  final Uint8List pdfBytes;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'ATS Friendly Resume',
          style: textStyle.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await BuildResumeApi().savePdfToDownloads(pdfBytes);
            },
            icon: Icon(Icons.download),
          ),
        ],
        backgroundColor: colorScheme.tertiaryContainer,
      ),
      body: SafeArea(child: SfPdfViewer.memory(pdfBytes)),
    );
  }
}
