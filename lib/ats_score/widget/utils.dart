import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resume_critiquer_app/model/card_content.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';
import 'package:resume_critiquer_app/ats_score/widget/error_bottom_sheet.dart';

class CustomIconData {
  final Icon icon;
  final Color color;

  const CustomIconData({required this.icon, required this.color});
}

class Utils {
  static CustomIconData getIcon({
    required final String label,
    final double? size,
  }) {
    IconData? icon;
    Color? color;
    if (label.contains('strength')) {
      icon = Icons.check_circle;
      color = Colors.greenAccent;
    } else if (label.contains('improvement')) {
      icon = Icons.warning_amber_rounded;
      color = Colors.amberAccent;
    } else if (label.contains('format')) {
      icon = Icons.article;
      color = Colors.deepPurple;
    } else if (label.contains('achieve') || label.contains('certificat')) {
      icon = Icons.star;
      color = Colors.yellow;
    } else if (label.contains('technical') ||
        label.contains('solving') ||
        label.contains('skill')) {
      icon = Icons.psychology;
      color = Colors.blueAccent;
    } else if (label.contains('tailor')) {
      icon = Icons.edit_note;
      color = Colors.lightGreenAccent;
    } else {
      icon = Icons.badge;
      color = Colors.cyan;
    }

    return CustomIconData(
      icon: Icon(icon, color: color, size: size ?? 14),
      color: color,
    );
  }

  static Icon getHeadingIcon({required String label, final double? size}) {
    label = label.replaceAll(' ', '').toLowerCase();
    IconData? icon;
    Color? color;

    if (label.contains('content')) {
      icon = Icons.visibility_outlined;
      color = Color(0xFF3B82F6);
    } else if (label.contains('skill')) {
      icon = Icons.psychology_alt_outlined;
      color = Color(0xFF8B5CF6);
    } else if (label.contains('specific')) {
      icon = Icons.track_changes_outlined;
      color = Color(0xFFF59E0B);
    } else if (label.contains('overall')) {
      icon = Icons.checklist_outlined;
      color = Color(0xFF64748B);
    } else {
      icon = Icons.work_outline;
      color = Color(0xFF10B981);
    }
    return Icon(icon, color: color, size: size ?? 24);
  }

  void showBlurLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha(120),
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void hideBlurLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showErrorBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onRetry,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => ErrorBottomSheet(
            title: title,
            message: message,
            onRetry: onRetry,
          ),
    );
  }

  static List<pw.Widget> _generateAnalysisPdf(
    final FileUploadResponse response,
  ) {
    textWidget(final String text, final double size, final bool isBold) =>
        pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: size,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        );

    final data = <pw.Widget>[];
    for (var entry in response.analysis!.entries) {
      final list = <CardContent>[];
      data.add(pw.SizedBox(height: 10));
      data.add(textWidget('${entry.key} :', 25, true));
      int index = 1;

      for (var entryData in entry.value.entries) {
        list.add(CardContent(title: entryData.key, points: entryData.value));

        data.add(
          pw.Padding(
            padding: pw.EdgeInsets.only(left: 10),
            child: textWidget('$index ${entryData.key}:', 20, true),
          ),
        );

        final widget = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: List.generate(
            entryData.value.data?.length ?? 0,
            (final index) =>
                textWidget('* ${entryData.value.data?[index]}', 20, false),
          ),
        );
        index++;
        data.add(
          pw.Padding(padding: pw.EdgeInsets.only(left: 20), child: widget),
        );
        data.add(pw.SizedBox(height: 3));
      }
      data.add(pw.SizedBox(height: 5));
    }

    return data;
  }

  static Future<Uint8List> generatePdfContent(
    final FileUploadResponse response,
  ) async {
    final pdf = pw.Document();

    textWidget(final String text, final double size, final bool isBold) =>
        pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: size,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build:
            (context) => [
              textWidget('Resume Insights', 32, true),
              pw.Divider(),

              pw.Row(
                children: [
                  textWidget('ATS Score : ', 25, true),
                  textWidget('${response.atsScore}', 20, false),
                ],
              ),

              pw.SizedBox(height: 10),

              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  textWidget('Summary : ', 25, true),
                  pw.Expanded(
                    child: textWidget('${response.summary}', 20, false),
                  ),
                ],
              ),

              pw.SizedBox(height: 20),

              ..._generateAnalysisPdf(response),
            ],
      ),
    );

    return pdf.save();
  }

}
