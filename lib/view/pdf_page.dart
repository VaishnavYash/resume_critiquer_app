import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/api/multipart_api.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';
import 'package:resume_critiquer_app/view/test.dart';
import 'package:resume_critiquer_app/view/widget/ats_score_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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

  // ChartData(this.category, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('PDF Upload Page'),

            TextButton(onPressed: _submitResume, child: Text('Submit')),

            Divider(),
            AtsScoreWidget(atsScore: response.atsScore?.toDouble() ?? 0.0),

            // ListView.builder(
            //   itemBuilder: (context, index) {
            //     return ListTile(title: Text(data[index]));
            //   },
            //   itemCount: data.length,
            //   shrinkWrap: true,
            // ),
          ],
        ),
      ),
    );
  }
}
