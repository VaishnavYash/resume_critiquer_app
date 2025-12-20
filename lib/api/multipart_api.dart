import 'dart:io';
import 'package:http/http.dart' as http;

class MultipartApi {
  Future<String> fileUploadMultipart({
    required final File file,
    required final String jobTtile,
  }) async {
    try {
      var uri = Uri.https('example.com', 'create-upload');
      var request =
          http.MultipartRequest('POST', uri)
            ..fields['job_role'] = jobTtile
            ..files.add(
              await http.MultipartFile.fromPath('resumeContent', file.path),
            );

      var response = await request.send();

      return response.stream.bytesToString().asStream().toString();

      // return FileUploadResponse(
      //   message: response.stream.bytesToString().asStream().toString(),
      // );
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }
}
