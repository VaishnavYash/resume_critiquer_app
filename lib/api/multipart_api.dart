import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resume_critiquer_app/model/file_upload_response.dart';

class MultipartApi {
  Future<FileUploadResponse> fileUploadMultipart({
    required final File file,
    required final String jobTtile,
  }) async {
    debugPrint('I am Here \n ');
    try {
      var uri = Uri.parse('http://192.168.1.6:8000/analyze_resume_pdf');
      var request =
          http.MultipartRequest('POST', uri)
            ..fields['job_role'] = jobTtile
            ..files.add(await http.MultipartFile.fromPath('resume', file.path));

      var response = await request.send();

      final responseBody = await response.stream.bytesToString();

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: $responseBody');

      return FileUploadResponse(message: responseBody.toString());
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }
}
