import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/analysis_page/view/resume_analysis_page.dart';
import 'package:resume_critiquer_app/main_page/api/multipart_api.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';
import 'package:resume_critiquer_app/main_page/widget/score_gauge/ats_score_widget.dart';

class PDFUploadPage extends StatefulWidget {
  const PDFUploadPage({super.key});

  @override
  State<PDFUploadPage> createState() => _PDFUploadPageState();
}

class _PDFUploadPageState extends State<PDFUploadPage> {
  // bool isFileUploaded = false;
  PlatformFile? file;
  FileUploadResponse response = FileUploadResponse();

  final List<String> data = [];

  // void _fileUploader() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     isFileUploaded = true;
  //     file = result.files.first;
  //     setState(() {});
  //   } else {
  //     isFileUploaded = false;
  //   }
  // }

  void _submitResume() async {
    // if (isFileUploaded) {
    response = await MultipartApi().fileUploadMultipart(
      // file: File(file!.path!),
      jobTtile: 'Sample Job Title',
    );
    _structureResponseData();
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please upload a PDF file before submitting.')),
    //   );
    // }
  }

  void _structureResponseData() {
    data.clear();
    data.add(
      response.atsScore != null
          ? 'ATS Score: ${response.atsScore}'
          : 'ATS Score: N/A',
    );
    data.add(
      response.summary != null
          ? 'Summary: ${response.summary}'
          : 'Summary: N/A',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('PDF Upload Page'),

          TextButton(onPressed: _submitResume, child: Text('Submit')),

          Divider(),
          SizedBox(
            width: 300,
            height: 300,
            child: AtsScoreWidget(
              atsScore: response.atsScore?.toDouble() ?? 0.0,
            ),
          ),

          if (response.summary != null) _summaryBlock(response.summary!),

          if (response.analysis?.isNotEmpty ?? false)
            ResumeAnalysisSection(jsonData: response.analysis!),

          // ConsoleView(
          //   title: 'Summary',
          //   detail:response.summary ?? '',
          // ),

          // if (response.analysis?.isNotEmpty ?? false)
          //   TypeOneCardWidget(data: response.analysis!.entries.first),

          // if (response.analysis?.isNotEmpty ?? false)
          //   HorizontalCarouselWidget(data: response.analysis!.entries.first),

          // ListView.builder(
          //   itemCount: 30,
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, value) {
          //     return TextWidget(
          //       text: 'PDF Upload Page',
          //       style: TextStyle(color: Colors.yellow),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _summaryBlock(final String summary) => Column(
    children: [
      const Text(
        "Professional Summary",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 8),

      // Summary text
      Text(
        summary,
        style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
      ),
      const SizedBox(height: 24),
    ],
  );
}

            // data: MapEntry('Content Clarity and Impact', {
            //   "Strengths": [
            //     "Professional summary succinctly outlines key skills and achievements.",
            //     "Experience section provides quantifiable results that demonstrate impact.",
            //     "Experience section provides quantifiable results that demonstrate impact.",
            //     "Experience section provides quantifiable results that demonstrate impact.",
            //     "Experience section provides quantifiable results that demonstrate impact.",
            //     "Experience section provides quantifiable results that demonstrate impact.",
            //     "Experience section provides quantifiable results that demonstrate impact.",
            //     "Experience section provides quantifiable results that demonstrate impact.",
            //     "Experience section provides quantifiable results that demonstrate impact.",
            //   ],
            //   "Areas of Improvement": [
            //     "Clarify the role and contributions in academic projects and experiences.",
            //     "Use more action-oriented language to enhance engagement.",
            //     "Use more action-oriented language to enhance engagement.",
            //     "Use more action-oriented language to enhance engagement.",
            //     "Use more action-oriented language to enhance engagement.",
            //     "Use more action-oriented language to enhance engagement.",
            //   ],
            // }),