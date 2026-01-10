import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:resume_critiquer_app/model/file_response_error.dart';

import 'package:resume_critiquer_app/model/file_upload_response.dart';

class MultipartApi {
  Future<FileUploadStatus> fileUploadMultipart({
    required final File file,
    required final String company,
    required final String jobTtile,
  }) async {
    var uri = Uri.parse(
      'https://resume-critique-backend-513240140256.asia-south1.run.app/analyze_resume_pdf',
    );
    // 'http://192.168.1.6:8080/analyze_resume_pdf',
    // 'http://localhost:8080/analyze_resume_pdf',

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
      final content = jsonData['content'];

      final decodedContent = content is String ? jsonDecode(content) : content;

      return FileUploadStatus(
        status: jsonData['status'],
        fileUploadResponse: FileUploadResponse.fromJson(decodedContent),
      );
    } else {
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
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/resume_analysis.pdf');

    await file.writeAsBytes(pdfContent, flush: true);
    return file;
  }
}


    // final responseBody =
    //     '''{"status":"success","content":{   "ats_score": 78,   "summary":"Skilled Android Developer with a strong foundation in Kotlin, Java, and Flutter, specializing in high-performance applications. Demonstrated ability in UI development and backend integration, contributing to major improvements in a top banking app.",   "analysis": {     "Content Clarity and Impact": {       "Strengths": {         "data": [           "Clear focus on relevant technologies and frameworks.",           "Quantifiable achievements highlight effectiveness.",           "Professional summary succinctly outlines key skills."         ],         "whyThisMatter": "Clarity and impact in content enhance the resume's ability to grab attention and demonstrate value quickly."       },       "Areas of Improvement": {         "data": [           "Include more specific metrics related to individual contributions.",           "Avoid redundancy in skills mentioned across sections.",           "Add a brief introductory sentence to the Experience section for context."         ],         "whyThisMatter": "Specific metrics and diverse language improve the uniqueness and persuasive power of the resume."       }     },     "Skills Presentation": {       "Strengths": {         "data": [           "Well-structured skills section highlighting relevant programming languages.",           "Inclusion of both hard and soft skills.",           "Use of industry-standard terminology."         ],         "whyThisMatter": "A well-presented skills section ensures compatibility with ATS and allows hiring managers to quickly assess qualifications."       },       "Areas of Improvement": {         "data": [           "Group similar skills together for easier reading.",           "Consider adding proficiency levels for each skill.",           "Remove any outdated or irrelevant technologies."         ],         "whyThisMatter": "Improving readability and relevance increases the likelihood of passing ATS filters."       }     },     "Experience Descriptions": {       "Strengths": {         "data": [           "Specific roles and responsibilities are clearly defined.",           "Use of action verbs to describe achievements.",           "Projects are detailed with technologies used."         ],         "whyThisMatter": "Well-defined experience descriptions convey the candidate's hands-on skills and contributions effectively."       },       "Areas of Improvement": {         "data": [           "Combine similar points to reduce redundancy.",           "Highlight leadership roles or initiatives taken.",           "Add context on the tools used in collaboration."         ],         "whyThisMatter": "Reducing redundancy and emphasizing leadership can make the candidate stand out more effectively."       }     },     "Specific Improvements for Sde at ": {       "Technical Depth": {         "data": [           "Emphasize advanced concepts in Kotlin or Java.",           "Include contributions to open-source or community projects.",           "Detail experience with cloud services or DevOps practices."         ],         "whyThisMatter": "Demonstrating technical depth aligns with SDE roles that often require comprehensive software engineering knowledge."       },       "Project Descriptions": {         "data": [           "Provide links to deployed applications or live demos.",           "Explain the impact of projects on end-users or stakeholders.",           "Include any collaborative aspects of projects."         ],         "whyThisMatter": "Detailed project descriptions showcase practical application of skills and the candidate's ability to contribute to team goals."       },       "Achievements": {         "data": [           "Quantify achievements related to team projects.",           "Highlight any awards or recognitions received.",           "Add any relevant hackathon or coding competition results."         ],         "whyThisMatter": "Quantifying achievements enhances credibility and shows a track record of success."       },       "Certifications": {         "data": [           "Consider listing the issuing organizations.",           "Prioritize certifications relevant to the SDE role.",           "Add completion dates for certifications."         ],         "whyThisMatter": "Relevant certifications provide additional validation of skills and commitment to professional development."       }     },     "Overall Recommendations": {       "Formatting": {         "data": [           "Use consistent bullet points and spacing.",           "Ensure uniform font sizes and styles.",           "Consider using headings for each section for clarity."         ],         "whyThisMatter": "Consistent formatting improves readability and professionalism of the resume."       },       "Tailoring": {         "data": [           "Customize the summary to reflect the specific SDE role.",           "Align project descriptions with the job's key responsibilities.",           "Incorporate keywords from the job description."         ],         "whyThisMatter": "Tailoring enhances the application's relevance to the specific role, increasing the chances of passing ATS."       },       "Proofreading": {         "data": [           "Check for any grammatical errors or typos.",           "Ensure consistency in tense throughout the resume.",           "Verify all technical terms are correctly spelled."         ],         "whyThisMatter": "A well-proofread resume reflects attention to detail, a critical skill for software development."       }     }   } }}''';
