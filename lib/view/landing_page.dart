import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resume_critiquer_app/framework/widgets/text_field_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/file_response_error.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';
import 'package:resume_critiquer_app/store/file_uploader_store.dart';
import 'package:resume_critiquer_app/view/pdf_page.dart';
import 'package:resume_critiquer_app/view/widget/glass_button.dart';
import 'package:resume_critiquer_app/view/widget/utils.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late ColorScheme colorScheme;
  late TextTheme textTheme;
  final fileUploaderStore = FileUploaderStore();

  final companyTextField = TextEditingController();
  final jobTextField = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    companyTextField.dispose();
    jobTextField.dispose();
    super.dispose();
  }

  Future<void> _submitResume() async {
    Utils().showBlurLoader(context);

    try {
      final response = await fileUploaderStore.uploadFileApi(
        jobTextField.text,
        companyTextField.text,
      );

      if (!mounted) return;
      Utils().hideBlurLoader(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => PDFUploadPage(
                response: response.fileUploadResponse ?? FileUploadResponse(),
              ),
        ),
      );
    } catch (err) {
      Utils().hideBlurLoader(context);

      if (err is ApiException) {
        Utils.showErrorBottomSheet(
          context,
          title: err.code.replaceAll('_', ' '),
          message: err.message,
        );
      } else {
        Utils.showErrorBottomSheet(
          context,
          title: 'Error',
          message: 'Something went wrong',
          onRetry: _submitResume,
        );
      }
    }
  }

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
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: _uploadCard(),
            onTap: () => _permissionPopUp(),
          ),
          const SizedBox(height: 18),
          TextFieldWidget(
            label: 'Company Applying for',
            hintText: 'Google (Optional)',
            controller: companyTextField,
          ),
          const SizedBox(height: 18),
          TextFieldWidget(
            label: 'Job Appling for *',
            hintText: 'SDE 1',
            controller: jobTextField,
            highlightColor: Colors.red,
            highlightWords: {'*'},
            validator: (final value) {
              if (value == null || value.isEmpty) {
                return 'This is the required Field';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          _analyzeButton(),
        ],
      ),
    ),
  );

  Future<void> _uploadFileOnTap() async {
    if (!mounted) return;
    Utils().showBlurLoader(context);
    await fileUploaderStore.uploadFile();
    if (!mounted) return;
    Utils().hideBlurLoader(context);
    return;
  }

  Future<void> _permissionPopUp() async {
    if (await Permission.storage.isGranted) {
      await _uploadFileOnTap();
      return;
    }
    if (!mounted) return;
    final status = await Permission.storage.request();

    if (status.isGranted) {
      await _uploadFileOnTap();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission is required')),
      );
    }
  }

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
                child: Observer(
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          fileUploaderStore.isFileUploaded
                              ? Icons.upload_file_rounded
                              : Icons.cloud,
                          size: 32,
                          color: colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(height: 8),
                        TextWidget(
                          text: fileUploaderStore.file?.name ?? 'Browse file',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: colorScheme.surface),
                        ),
                      ],
                    );
                  },
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
    onTap: () async {
      if (fileUploaderStore.isFileUploaded == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Please upload a PDF file before submitting.',
              style: textTheme.bodyMedium!.copyWith(color: Colors.black),
            ),
          ),
        );
      } else if (_formKey.currentState!.validate()) {
        await _submitResume();
      }
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
