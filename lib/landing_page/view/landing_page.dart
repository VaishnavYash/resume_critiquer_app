import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/widgets/text_field_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/main_page/view/pdf_page.dart';
import 'package:resume_critiquer_app/landing_page/widget/glass_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late ColorScheme colorScheme;
  late TextTheme textTheme;

  bool isFileUploaded = false;
  PlatformFile? file;
  final companyTextField = TextEditingController();
  final jobTextField = TextEditingController();

  @override
  void dispose() {
    companyTextField.dispose();
    jobTextField.dispose();
    file = null;
    isFileUploaded = false;
    super.dispose();
  }

  void _fileUploader() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      isFileUploaded = true;
      file = result.files.first;
      setState(() {});
    }
    if (file == null) {
      isFileUploaded = false;
    }
  }

  // void _submitResume() async {
  //   // if (isFileUploaded) {
  //   response = await MultipartApi().fileUploadMultipart(
  //     // file: File(file!.path!),
  //     jobTtile: 'Sample Job Title',
  //   );
  //   _structureResponseData();
  //   // } else {
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     SnackBar(content: TextWidget(text:'Please upload a PDF file before submitting.')),
  //   //   );
  //   // }
  // }

  // void _structureResponseData() {
  //   data.clear();
  //   data.add(
  //     response.atsScore != null
  //         ? 'ATS Score: ${response.atsScore}'
  //         : 'ATS Score: N/A',
  //   );
  //   data.add(
  //     response.summary != null
  //         ? 'Summary: ${response.summary}'
  //         : 'Summary: N/A',
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: _topBar(),
        backgroundColor: colorScheme.tertiaryContainer,
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _topStackWidget()),
            SliverFillRemaining(hasScrollBody: false, child: _mainContent()),
          ],
        ),
      ),
    );
  }

  Widget _topStackWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 60),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            colorScheme.secondaryContainer,
            colorScheme.tertiaryContainer,
            colorScheme.tertiaryContainer,
          ],
        ),
      ),
      child: TextWidget(
        alignment: TextAlign.center,
        text: 'Improve your resume\nwith AI insights',
        style: Theme.of(
          context,
        ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _mainContent() => Container(
    width: MediaQuery.sizeOf(context).width,
    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      gradient: LinearGradient(
        colors: [
          colorScheme.onPrimaryFixedVariant,
          colorScheme.onSecondaryFixed,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: _uploadCard(),
          onTap: () {
            _fileUploader();
          },
        ),
        const SizedBox(height: 18),
        TextFieldWidget(
          label: 'Company Applying for',
          hintText: 'Google',
          controller: companyTextField,
        ),
        const SizedBox(height: 18),
        TextFieldWidget(
          label: 'Job Appling for',
          hintText: 'SDE 1',
          controller: jobTextField,
        ),
        const SizedBox(height: 24),
        _analyzeButton(),
      ],
    ),
  );

  Widget _uploadCard() => ClipRRect(
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
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                const Icon(Icons.cloud_upload_outlined),
              ],
            ),
            const SizedBox(height: 4),
            TextWidget(
              text: "Supported files: PDF",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      isFileUploaded ? Icons.upload_file_rounded : Icons.cloud,
                      size: 32,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 8),
                    TextWidget(
                      text: file?.name ?? 'Browse file',
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

  Widget _topBar() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.document_scanner, size: 22),
      SizedBox(width: 20),
      TextWidget(
        text: 'Welcome!',
        style: textTheme.titleMedium?.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
      ),
    ],
  );

  Widget _analyzeButton() => GlassButton(
    textWidget: Center(
      child: TextWidget(
        text: 'Analyze Resume',
        style: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
          letterSpacing: 0.5,
        ),
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (final context) => PDFUploadPage()),
      );
    },
    colorsList: [
      colorScheme.primaryContainer,
      colorScheme.surface,
      colorScheme.surface,
      colorScheme.surface,
      colorScheme.primaryContainer,
    ],
  );
}
