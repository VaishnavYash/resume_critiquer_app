import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resume_critiquer_app/build_resume/build_resume.dart';
import 'package:resume_critiquer_app/framework/widgets/text_button_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_field_widget.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:resume_critiquer_app/model/build_resume_model.dart';
import 'package:resume_critiquer_app/model/file_response_error.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';
import 'package:resume_critiquer_app/model/save_data_response.dart';
import 'package:resume_critiquer_app/store/file_uploader_store.dart';
import 'package:resume_critiquer_app/ats_score/history_page.dart';
import 'package:resume_critiquer_app/ats_score/pdf_page.dart';
import 'package:resume_critiquer_app/ats_score/widget/hiev_code.dart';
import 'package:resume_critiquer_app/ats_score/widget/utils.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late ColorScheme colorScheme;
  late TextTheme textStyle;
  final _fileUploaderStore = FileUploaderStore();

  final _jobTextField = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var showUnderLine = false;

  @override
  void dispose() {
    _jobTextField.dispose();
    super.dispose();
  }

  Future<void> _submitResume() async {
    Utils().showBlurLoader(context);

    try {
      final response = await _fileUploaderStore.uploadFileApi(
        _jobTextField.text,
      );

      if (response.fileUploadResponse != null) {
        final allHiveResponse = HiveCode.getAllResponses();

        await HiveCode.saveResponses([
          HistoryResponse(
            uploadName: _fileUploaderStore.file?.name ?? '',
            uploadResponse: response.fileUploadResponse!,
          ),
          ...allHiveResponse,
        ]);
      }

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

  Future<void> _getNewResumeData() async {
    Utils().showBlurLoader(context);

    try {
      final response = await _fileUploaderStore.buildResumeData(
        _jobTextField.text,
      );

      // if (response.content != null) {
      // final allHiveResponse = HiveCode.getAllResponses();

      // await HiveCode.saveResponses([
      //   HistoryResponse(
      //     uploadName: _fileUploaderStore.file?.name ?? '',
      //     uploadResponse: response.fileUploadResponse!,
      //   ),
      //   ...allHiveResponse,
      // ]);
      // }

      if (!mounted) return;
      Utils().hideBlurLoader(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => BuildResume(
                buildResumeContent: response.content ?? BuildResumeContent(),
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
    textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: _topBar(),
        actions: [
          IconButton(
            onPressed: () => _onHistoryPress(),
            icon: Icon(Icons.history, color: colorScheme.onPrimary),
          ),
        ],
        backgroundColor: colorScheme.tertiaryContainer,
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: SafeArea(
        child: Column(
          children: [
            _topStackWidget(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: _mainContent(),
                    ),
                  );
                },
              ),
            ),
            _bottomBar(),
          ],
        ),
      ),
    );
  }

  void _onHistoryPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (final context) => HistoryPage()),
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
        style: textStyle.displayMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _mainContent() => Container(
    width: MediaQuery.sizeOf(context).width,
    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
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
            label: 'Job Description',
            hintText:
                'e.g. • Lead a team of developers • Manage product lifecycles • Required: 3+ years of Flutter experience',
            controller: _jobTextField,
            validator: (final value) {
              if (value == null || value.isEmpty) {
                return 'This is the required Field';
              }
              return null;
            },
          ),
        ],
      ),
    ),
  );

  Future<void> _uploadFileOnTap() async {
    if (!mounted) return;
    Utils().showBlurLoader(context);
    await _fileUploaderStore.uploadFile();
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
                  style: textStyle.bodyLarge?.copyWith(
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
              style: textStyle.bodyMedium?.copyWith(
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
                color: colorScheme.primary,
              ),
              child: Center(
                child: Observer(
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _fileUploaderStore.isFileUploaded
                              ? Icons.upload_file_rounded
                              : Icons.cloud,
                          size: 32,
                          color: colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(height: 8),
                        TextWidget(
                          text: _fileUploaderStore.file?.name ?? 'Browse file',
                          style: textStyle.bodyLarge?.copyWith(
                            color: colorScheme.surface,
                          ),
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
      Icon(Icons.document_scanner, color: colorScheme.onPrimary),
      SizedBox(width: 20),
      TextWidget(
        text: 'Welcome!',
        style: textStyle.titleMedium?.copyWith(color: colorScheme.onPrimary),
      ),
    ],
  );

  Widget _analyzeButton() => SizedBox(
    height: 45,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.surface,
      ),
      child: Center(
        child: TextWidget(
          text: 'Get ATS Score',
          style: textStyle.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
            letterSpacing: 0.5,
          ),
        ),
      ),
      onPressed: () async {
        if (_fileUploaderStore.isFileUploaded == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: TextWidget(
                text: 'Please upload a PDF file before submitting.',
                style: textStyle.bodyMedium!.copyWith(color: Colors.black),
              ),
            ),
          );
        } else if (_formKey.currentState!.validate()) {
          await _submitResume();
        }
      },
    ),
  );

  Widget _bottomBar() => Container(
    color: colorScheme.onSecondaryFixed,
    padding: EdgeInsets.fromLTRB(21, 10, 21, 24),
    child: Column(
      spacing: 15,
      children: [
        _analyzeButton(),
        TextButtonWidget(
          onPress: () async {
            // final pdfBytes = await Utils.generatePdfContent(widget.response);
            // _savedPdf = await MultipartApi().downloadPdf(pdfBytes);
            _getNewResumeData();
          },
        ),
      ],
    ),
  );
}
