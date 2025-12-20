import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/api/multipart_api.dart';

class PDFUploadPage extends StatefulWidget {
  const PDFUploadPage({super.key});

  @override
  State<PDFUploadPage> createState() => _PDFUploadPageState();
}

class _PDFUploadPageState extends State<PDFUploadPage> {
  bool isFileUploaded = false;
  PlatformFile? file;

  void _fileUploader() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      isFileUploaded = true;
      file = result.files.first;
    } else {
      isFileUploaded = false;
    }
    setState(() {});
  }

  void _submitResume() {
    if (isFileUploaded) {
      MultipartApi().fileUploadMultipart(
        file: File(file!.path!),
        jobTtile: 'Sample Job Title',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload a PDF file before submitting.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('PDF Upload Page'),
        IconButton(onPressed: _fileUploader, icon: Icon(Icons.upload_file)),
        if (isFileUploaded)
          Text('File Uploaded: ${file!.name} (${file!.size} bytes)')
        else
          Text('No File Uploaded Yet! Try Again.'),

        TextButton(onPressed: _submitResume, child: Text('Submit')),
      ],
    );
  }
}
