import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class InAppPdfViewer extends StatefulWidget {
  const InAppPdfViewer({super.key});

  @override
  State<InAppPdfViewer> createState() => _InAppPdfViewerState();
}

class _InAppPdfViewerState extends State<InAppPdfViewer> {
  final direction = '/storage/emulated/0/Download/resume_analysis.pdf';
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'PDF Pre-view',
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ),
      body: SafeArea(child: SfPdfViewer.file(File(direction))),
    );
  }
}
