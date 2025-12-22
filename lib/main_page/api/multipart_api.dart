import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:resume_critiquer_app/model/file_upload_response.dart';

class MultipartApi {
  Future<FileUploadResponse> fileUploadMultipart({
    final File? file,
    required final String jobTtile,
  }) async {
    try {
      var response =
          '''{\n  \"ats_score\": 85,\n  \"summary\": \"Aspiring Software Development Engineer with a strong focus on mobile app development and a proven track record of enhancing application performance and reliability. Adept in Agile methodologies and skilled in utilizing modern development frameworks and languages.\",\n  \"analysis\": [\n    {\n      \"Content Clarity and Impact\": {\n        \"Strengths\": [\n          \"Professional summary succinctly outlines key skills and achievements.\",\n          \"Experience section provides quantifiable results that demonstrate impact.\"\n        ],\n        \"Areas of Improvement\": [\n          \"Clarify the role and contributions in academic projects and experiences.\",\n          \"Use more action-oriented language to enhance engagement.\"\n        ]\n      },\n      \"Skills Presentation\": {\n        \"Strengths\": [\n          \"Technical skills are well-categorized and relevant to the target role.\",\n          \"Diverse programming languages and frameworks are listed.\"\n        ],\n        \"Areas of Improvement\": [\n          \"Consider prioritizing skills based on relevance to Google’s tech stack.\",\n          \"Remove redundancy in listing tools and software.\"\n        ]\n      },\n      \"Experience Descriptions\": {\n        \"Strengths\": [\n          \"Demonstrates leadership and innovation in current role at TCS.\",\n          \"Highlights successful collaboration with cross-functional teams.\"\n        ],\n        \"Areas of Improvement\": [\n          \"Add more context to the impact of academic projects on personal development.\",\n          \"Enhance descriptions with specific technologies used in projects.\"\n        ]\n      },\n      \"Specific Improvements for Software Engineer at Google\": {\n        \"Technical Depth\": [\n          \"Include more details on algorithms and data structures used in projects.\",\n          \"Showcase experience with cloud platforms or services if applicable.\"\n        ],\n        \"Project Descriptions\": [\n          \"Expand on the technical challenges faced during project development.\",\n          \"Emphasize the scalability and performance aspects of the projects.\"\n        ],\n        \"Achievements\": [\n          \"Quantify achievements with specific metrics for coding challenges.\",\n          \"Highlight any awards or recognitions for contributions to projects.\"\n        ],\n        \"Certifications\": [\n          \"List certifications in order of relevance to the software engineering role.\",\n          \"Consider adding any ongoing or relevant coursework.\"\n        ]\n      },\n      \"Overall Recommendations\": {\n        \"Formatting\": [\n          \"Ensure consistent formatting throughout the resume.\",\n          \"Use bullet points uniformly to improve readability.\"\n        ],\n        \"Tailoring\": [\n          \"Align the language and keywords more closely with Google’s job descriptions.\",\n          \"Incorporate Google’s values and mission in the professional summary.\"\n        ],\n        \"Proofreading\": [\n          \"Check for any grammatical or typographical errors.\",\n          \"Ensure clarity and conciseness in all descriptions.\"\n        ]\n      }\n    }\n  ]\n}''';
      // var uri = Uri.parse('https://resume-critique-513240140256.asia-south1.run.app/analyze_resume_pdf');
      // var request =
      //     http.MultipartRequest('POST', uri)
      //       ..fields['job_role'] = jobTtile
      //       ..files.add(await http.MultipartFile.fromPath('resume', file.path));

      // var response = await request.send();

      // final responseBody = await response.stream.bytesToString();

      // debugPrint('Response status: ${response.statusCode}');
      // debugPrint('Response body: $responseBody');
      final responseBody = response.replaceAll('/n', '');

      final jsonData = jsonDecode(responseBody) as Map<String, dynamic>;

      return FileUploadResponse.fromJson(jsonData);
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }
}
