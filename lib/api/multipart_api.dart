import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resume_critiquer_app/model/file_response_error.dart';

import 'package:resume_critiquer_app/model/file_upload_response.dart';

class MultipartApi {
  Future<FileUploadStatus> fileUploadMultipart({
    required final File file,
    required final String company,
    required final String jobTtile,
  }) async {
    var uri = Uri.parse(
      // https://resume-critique-513240140256.asia-south1.run.app/
      'http://192.168.1.6:8000/analyze_resume_pdf',
    );

    var request =
        http.MultipartRequest('POST', uri)
          ..fields['job_role'] = jobTtile
          ..fields['company'] = company
          ..files.add(await http.MultipartFile.fromPath('resume', file.path));

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: $responseBody');

    Map<String, dynamic> jsonData;

    try {
      jsonData = jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      throw ApiException(
        code: 'INVALID_RESPONSE',
        message: 'Server returned an invalid response',
      );
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // SUCCESSfinal
      final content = jsonData['content'];

      final decodedContent = content is String ? jsonDecode(content) : content;

      return FileUploadStatus(
        status: jsonData['status'],
        fileUploadResponse: FileUploadResponse.fromJson(decodedContent),
      );
    } else {
      // ERROR
      final detail = jsonData['detail'];

      if (detail is Map<String, dynamic>) {
        throw ApiException(
          code: detail['code'] ?? 'UNKNOWN_ERROR',
          message: detail['message'] ?? 'Something went wrong',
        );
      } else {
        throw ApiException(
          code: 'UNKNOWN_ERROR',
          message: detail?.toString() ?? 'Something went wrong',
        );
      }
    }
  }

  Future<File> downloadPdf(Uint8List pdfContent) async {
    final directory = Directory('/storage/emulated/0/Download');

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final file = File('${directory.path}/resume_analysis.pdf');
    await file.writeAsBytes(pdfContent);

    return file;
  }
}
