import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resume_critiquer_app/model/build_resume_model.dart';

class NewResumePdf {
  static pw.Widget textWidget(
    final String? text, {
    final double size = 10,
    bool isBold = false,
  }) => pw.Text(
    text ?? '',
    style: pw.TextStyle(
      fontSize: size,
      fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
    ),
  );

  static pw.Widget rowWidget(
    final String? title,
    final String? value, {
    final double size = 10,
    final bool bold = false,
    final bool showBullet = false,
  }) => pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      if (showBullet)
        pw.Row(
          children: [
            pw.Text('\u2022 ', style: pw.TextStyle(fontSize: size)),
            textWidget(title ?? '', size: size, isBold: bold),
          ],
        ),
      if (!showBullet) textWidget(title ?? '', size: size, isBold: bold),
      textWidget(value ?? '', size: 10),
    ],
  );

  static pw.Widget sectionTitle(final String title) => pw.Column(
    mainAxisAlignment: pw.MainAxisAlignment.start,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      textWidget(title.toUpperCase(), size: 12, isBold: true),
      pw.Divider(),
    ],
  );

  static pw.Widget firstSectionTitle(final Education? education) => pw.Column(
    children: [
      rowWidget('User Name', 'Mobile Number', size: 16),
      rowWidget(education?.degree, 'email Id'),
      rowWidget(education?.domain, 'Github Link'),
      rowWidget(education?.institution, 'LinkedIn Profile'),
    ],
  );

  static pw.Widget summaryBlock(final String summary) => pw.Column(
    children: [sectionTitle('Professional Summary'), textWidget(summary)],
  );

  static pw.Widget educationBlock(final List<Education>? education) {
    if (education == null || education.isEmpty) {
      return pw.SizedBox.shrink();
    }
    return pw.Column(
      children: [
        sectionTitle('Education'),
        ...education.map(
          (edu) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              rowWidget(
                edu.institution,
                '${edu.from ?? ''} - ${edu.to ?? ''}',
                size: 12,
                bold: true,
                showBullet: education.length == 1 ? false : true,
              ),
              textWidget(
                edu.domain != null && edu.degree != null
                    ? '${edu.degree} in ${edu.domain}'
                    : edu.degree ?? edu.domain,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget experienceBlock(final List<Experience>? experience) {
    if (experience == null || experience.isEmpty) {
      return pw.SizedBox.shrink();
    }
    return pw.Column(
      children: [
        sectionTitle('Experience'),
        ...experience.map(
          (exp) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              rowWidget(
                exp.company,
                '${exp.from ?? ''} - ${exp.to ?? ''}',
                bold: true,
                showBullet: experience.length == 1 ? false : true,
              ),
              rowWidget(
                exp.topic != null
                    ? '${exp.role} | Topic: ${exp.topic} '
                    : exp.role,
                'Location',
              ),
              ...(exp.bullets ?? []).map(
                (final value) => textWidget('- $value'),
              ),
              pw.SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget projectBlock(final List<Project>? project) {
    if (project == null || project.isEmpty) {
      return pw.SizedBox.shrink();
    }
    return pw.Column(
      children: [
        sectionTitle('Projects'),
        ...project.map(
          (proj) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              rowWidget(
                proj.name,
                'from - to',
                bold: true,
                showBullet: project.length == 1 ? false : true,
              ),
              rowWidget(
                proj.tools?.map((tool) => tool).join(' | '),
                'Gitub Link',
              ),
              ...(proj.description ?? []).map(
                (final value) => textWidget('- $value'),
              ),
              pw.SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  static Future<Uint8List> generatePdfContent(
    final BuildResumeContent response,
  ) async {
    final pdf = pw.Document();

    final summary = response.summary ?? '';
    final education = response.education;
    final experience = response.experience;
    final projects = response.projects;
    final skills = response.skills;
    final achievement = response.achievement;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build:
            (context) => [
              firstSectionTitle(education?[0]),
              summaryBlock(summary),
              educationBlock(education),
              experienceBlock(experience),
              projectBlock(projects),
            ],
      ),
    );

    return pdf.save();
  }
}
