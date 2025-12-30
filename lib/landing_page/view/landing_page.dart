import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_field_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/view/pdf_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  // backgroundColor: const Color(0xFF0B1020),
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [_topStackWidget(context), _mainContent(context)],
        ),
      ),
    );
  }

  Widget _topStackWidget(final BuildContext context) => Container(
    padding: EdgeInsets.all(10),
    height: 280,
    width: MediaQuery.sizeOf(context).width,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4A5CF3),
          Color(0xFF7B5CFF),
          Color(0xFF7B5CFF),
          Color(0xFF7B5CFF),
        ],
      ),
    ),
    child: Column(children: [_topBar(context), _header(context)]),
  );

  Widget _mainContent(final BuildContext context) => Positioned(
    top: MediaQuery.sizeOf(context).height / 4,
    child: Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF141B34), Color(0xFF0B1020)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _uploadCard(context),
          const SizedBox(height: 18),
          TextFieldWidget(label: 'Company Applying for', hintText: 'Google'),
          const SizedBox(height: 18),
          TextFieldWidget(label: 'Job Appling for', hintText: 'SDE 1'),
          const SizedBox(height: 24),
          _analyzeButton(context),
        ],
      ),
    ),
  );

  Widget _uploadCard(final BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colorScheme.primaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_outlined),
                  const SizedBox(width: 8),
                  TextWidget(
                    text: 'Upload Resume',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.cloud_upload_outlined),
                ],
              ),
              const SizedBox(height: 4),
              TextWidget(
                text: "Supported files: PDF",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: colorScheme.onTertiary,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud,
                        size: 32,
                        color: colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(height: 8),
                      TextWidget(
                        text: "Browse file",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colorScheme.surface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(final BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.document_scanner, size: 22),
      SizedBox(width: 20),
      TextWidget(
        text: 'Welcome!',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    ],
  );

  Widget _header(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30),
        TextWidget(
          alignment: TextAlign.center,
          text: 'Improve your resume\nwith AI insights',
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _analyzeButton(final BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (final context) => PDFUploadPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero,
          backgroundColor: colorScheme.surface,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5B7CFF), Color(0xFF6A5BFF)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: TextWidget(
              text: "Analyze Resume",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}
