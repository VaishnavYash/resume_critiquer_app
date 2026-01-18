import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:resume_critiquer_app/model/other/file_response_error.dart';

import 'package:resume_critiquer_app/model/file_upload/file_upload_response.dart';

class MultipartApi {
  Future<FileUploadStatus> fileUploadMultipart({
    required final File file,
    required final String jobTtile,
  }) async {
    var uri = Uri.parse(
      // 'https://resume-critique-backend-513240140256.asia-south1.run.app/analyze_resume_pdf',
      'http://192.168.1.6:8000/analyze_resume_pdf',
      // 'http://localhost:8080/analyze_resume_pdf',
    );

    var request =
        http.MultipartRequest('POST', uri)
          ..fields['job_description'] = jobTtile
          ..files.add(await http.MultipartFile.fromPath('resume', file.path));

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

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

  Future<void> downloadPdf(Uint8List pdfBytes) async {
    final fileName =
        'ats_score_data_${DateTime.now().millisecondsSinceEpoch}.pdf';

    const platform = MethodChannel('pdf_download');

    await platform.invokeMethod('savePdf', {
      'bytes': pdfBytes,
      'fileName': fileName,
    });

    OpenFilex.open('/storage/emulated/0/Download/$fileName');
  }
}
// final responseBody =
//         '''{ "status": "success", "content": { "ats_score": 85, "summary": "Results-driven Android Developer with expertise in Kotlin, Java, and Flutter, experienced in building secure, scalable mobile applications using MVVM and REST APIs, with a focus on performance and reliability.", "analysis": { "Content Clarity and Impact": { "Strengths": { "data": [ "Professional summary clearly highlights key skills and experiences.", "Specific achievements in previous roles demonstrate measurable impact.", "Use of industry-relevant terminology enhances credibility." ], "whyThisMatter": "Clear and impactful content helps in quickly capturing the attention of hiring managers and ATS." }, "Areas of Improvement": { "data": [ "Consider restructuring education section to highlight relevant coursework.", "Eliminate minor typos for a more polished presentation.", "Reduce redundancy in descriptions to enhance clarity." ], "whyThisMatter": "Improving clarity and conciseness can enhance ATS readability and overall impression." } }, "Skills Presentation": { "Strengths": { "data": [ "Technical skills are categorized effectively for easy scanning.", "Inclusion of both programming languages and frameworks is beneficial.", "Skills relevant to the target role are prominently featured." ], "whyThisMatter": "A well-presented skills section improves ATS matching and highlights qualifications effectively." }, "Areas of Improvement": { "data": [ "Add specific skills related to required technologies like Firebase and MongoDB.", "Ensure all skills align with the job description to enhance relevance.", "Consider using a visual format (e.g., bullet points) for easier readability." ], "whyThisMatter": "Tailoring the skills section to match job requirements increases chances of passing ATS filters." } }, "Experience Descriptions": { "Strengths": { "data": [ "Experience section uses action verbs that convey impact.", "Quantifiable achievements provide evidence of skills and contributions.", "Relevant project experience aligns well with job requirements." ], "whyThisMatter": "Strong experience descriptions enhance credibility and demonstrate capability." }, "Areas of Improvement": { "data": [ "Incorporate specific mentions of analytics and business logic in project descriptions.", "Expand on collaboration with cross-functional teams to showcase teamwork.", "Clarify the impact of your contributions on business outcomes." ], "whyThisMatter": "Adding relevant details can strengthen the narrative and match the job's key responsibilities." } }, "Specific Improvements for Developer": { "Technical Depth": { "data": [ "Enhance descriptions of technical projects to include Firebase and MongoDB usage.", "Detail your understanding of REST API design and implementation.", "Showcase any experience with app maintenance or stability improvements." ], "whyThisMatter": "Demonstrating technical depth in required areas increases alignment with job expectations." }, "Project Descriptions": { "data": [ "Highlight key challenges faced and how they were overcome in project descriptions.", "Include metrics related to performance improvements achieved in projects.", "Mention any user feedback or results that validate project success." ], "whyThisMatter": "Effective project descriptions can illustrate problem-solving skills and technical ownership." }, "Achievements": { "data": [ "Consider adding specific metrics related to your coding challenges achievements.", "Highlight any leadership roles or initiatives taken in projects.", "Mention any awards or recognition received for contributions." ], "whyThisMatter": "Achievements provide concrete evidence of capabilities and dedication." }, "Certifications": { "data": [ "Add completion dates for certifications to show ongoing learning.", "Include any relevant online courses or training related to required skills.", "Prioritize certifications that directly align with the Developer role." ], "whyThisMatter": "Relevant certifications enhance credibility and showcase commitment to professional development." } }, "Overall Recommendations": { "Formatting": { "data": [ "Ensure consistent formatting throughout the resume for a professional appearance.", "Use headers and subheaders to break up sections clearly.", "Avoid excessive use of punctuation to maintain clarity." ], "whyThisMatter": "Professional formatting can enhance readability and maintain ATS compliance." }, "Tailoring": { "data": [ "Customize the resume for each application to highlight relevant experiences.", "Use keywords from the job description to improve ATS matching.", "Focus on skills and experiences that align closely with the job role." ], "whyThisMatter": "Tailoring resumes for specific roles increases the likelihood of attracting hiring manager attention." }, "Proofreading": { "data": [ "Review the resume for grammatical errors and typos.", "Ensure all information is up-to-date and accurately reflects experiences.", "Consider seeking feedback from peers for additional insights." ], "whyThisMatter": "A polished resume reflects attention to detail and professionalism." } } } } }''';
    