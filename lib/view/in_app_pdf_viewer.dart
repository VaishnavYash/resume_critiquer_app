import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class InAppPdfViewer extends StatelessWidget {
  final File file;

  const InAppPdfViewer({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'PDF Preview',
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ),
      body: SafeArea(
        child: SfPdfViewer.file(file),
      ),
    );
  }
}
