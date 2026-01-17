import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resume_critiquer_app/build_resume/utils.dart';
import 'package:resume_critiquer_app/model/build_resume/build_resume_model.dart';

class NewResumePdf {
  static String unicode = '\u26AB';

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
            textWidget('$unicode ', size: size),
            textWidget(title ?? '', size: size, isBold: bold),
          ],
        ),
      if (!showBullet) textWidget(title ?? '', size: size, isBold: bold),
      textWidget(value ?? '', size: 10),
    ],
  );

  static pw.Widget sectionTitle(final String title) => pw.Container(
    padding: const pw.EdgeInsets.only(top: 5, bottom: 4),
    decoration: pw.BoxDecoration(
      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey, width: 1)),
    ),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              textWidget(title[0].toUpperCase(), size: 12, isBold: true),
              textWidget(
                title.substring(1).toUpperCase(),
                size: 10,
                isBold: true,
              ),
            ],
          ),
        ),
      ],
    ),
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
              pw.SizedBox(height: 4),
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
              pw.SizedBox(height: 4),
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
                exp.location,
              ),
              ...(exp.bullets ?? []).map(
                (final value) => textWidget('- $value'),
              ),
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
              pw.SizedBox(height: 4),
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
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget skillBlock(final Map<String, List<String>>? skills) {
    if (skills == null) {
      return pw.SizedBox.shrink();
    }

    final list = <pw.Widget>[];
    skills.forEach((final key, final value) {
      final String skill = value.join(', ');
      list.add(
        pw.Row(
          children: [
            textWidget(
              '$unicode ${BuildResumeUtils.firstCapitalAfterSpace(key)}: ',
              isBold: true,
            ),
            textWidget(skill),
          ],
        ),
      );
    });

    return pw.Column(children: [sectionTitle('Skills'), ...list]);
  }

  static pw.Widget achievementBlock(final List<String>? achievements) {
    if (achievements == null || achievements.isEmpty) {
      return pw.SizedBox.shrink();
    }
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        sectionTitle('Achievements'),
        ...achievements.map(
          (achieve) => textWidget(
            '- ${BuildResumeUtils.removeSpecialCharacters(achieve)}',
          ),
        ),
      ],
    );
  }

  static Future<Uint8List> generatePdfContent(
    final BuildResumeContent response,
  ) async {
    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Roboto/static/Roboto-Regular.ttf'),
    );

    final boldFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Roboto/static/Roboto-Bold.ttf'),
    );

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
    );

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
              summaryBlock(BuildResumeUtils.removeSpecialCharacters(summary)),
              educationBlock(education),
              experienceBlock(experience),
              projectBlock(projects),
              skillBlock(skills),
              achievementBlock(achievement),
            ],
      ),
    );

    return pdf.save();
  }
}
