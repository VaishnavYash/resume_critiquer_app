import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resume_critiquer_app/model/file_upload_response.dart';

class MultipartApi {
  Future<FileUploadResponse> fileUploadMultipart({
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
    try {
      // var response =
      //     '''""{\n  \"ats_score\": 85,\n  \"summary\": \"Aspiring Software Development Engineer with expertise in mobile app development, demonstrating strong technical skills and a proven ability to deliver high-quality software solutions.\",\n  \"analysis\": {\n    \"Content Clarity and Impact\": {\n      \"Strengths\": {\n        \"data\": [\n          \"Clear professional summary highlighting key skills and experiences.\",\n          \"Quantifiable achievements that demonstrate impact on projects.\",\n          \"Well-structured education and experience sections.\"\n        ],\n        \"whyThisMatter\": \"Clear content and quantifiable achievements enhance the likelihood of passing ATS filters and capture hiring managers' attention.\"\n      },\n      \"Areas of Improvement\": {\n        \"data\": [\n          \"Simplify technical jargon to enhance readability.\",\n          \"Use action verbs consistently to strengthen impact.\",\n          \"Consider adding a personal statement or additional context to career goals.\"\n        ],\n        \"whyThisMatter\": \"Improving clarity can make the resume more accessible to non-technical reviewers and enhance the overall impression.\"\n      }\n    },\n    \"Skills Presentation\": {\n      \"Strengths\": {\n        \"data\": [\n          \"Comprehensive technical skills list tailored to the software engineering role.\",\n          \"Diverse range of programming languages and frameworks listed.\",\n          \"Emphasis on both software development and problem-solving skills.\"\n        ],\n        \"whyThisMatter\": \"A well-presented skills section ensures alignment with job descriptions and improves ATS compatibility.\"\n      },\n      \"Areas of Improvement\": {\n        \"data\": [\n          \"Organize skills into categories for better readability.\",\n          \"Highlight the most relevant skills for the desired position.\",\n          \"Consider including proficiency levels for each skill.\"\n        ],\n        \"whyThisMatter\": \"A well-categorized skills section allows for quicker assessment by recruiters and ATS.\"\n      }\n    },\n    \"Experience Descriptions\": {\n      \"Strengths\": {\n        \"data\": [\n          \"Detailed descriptions of responsibilities and achievements.\",\n          \"Use of metrics to demonstrate success in prior roles.\",\n          \"Experience in diverse environments (e.g., academia and industry).\"\n        ],\n        \"whyThisMatter\": \"Experience descriptions that include metrics and specific contributions provide clear evidence of competency.\"\n      },\n      \"Areas of Improvement\": {\n        \"data\": [\n          \"Use more active verbs to describe experiences.\",\n          \"Integrate relevant technologies used in each role.\",\n          \"Ensure consistency in formatting and tense throughout.\"\n        ],\n        \"whyThisMatter\": \"Active language and technology integration can improve the impact and clarity of experience descriptions.\"\n      }\n    },\n    \"Specific Improvements for Software Engineer at Google\": {\n      \"Technical Depth\": {\n        \"data\": [\n          \"Include advanced projects or experiences with cutting-edge technology.\",\n          \"Demonstrate understanding of software engineering principles.\",\n          \"Consider adding contributions to open-source projects.\"\n        ],\n        \"whyThisMatter\": \"Google values technical depth; showcasing advanced knowledge can set the candidate apart.\"\n      },\n      \"Project Descriptions\": {\n        \"data\": [\n          \"Detail the specific technologies and methodologies used in projects.\",\n          \"Highlight collaborative aspects and the impact of projects.\",\n          \"Include links to project repositories or live demos.\"\n        ],\n        \"whyThisMatter\": \"Thorough project descriptions can illustrate practical application of skills and teamwork.\"\n      },\n      \"Achievements\": {\n        \"data\": [\n          \"Include any awards or recognitions in coding competitions.\",\n          \"Consider quantifying achievements related to project success.\",\n          \"Mention any leadership roles within projects or teams.\"\n        ],\n        \"whyThisMatter\": \"Achievements can differentiate candidates and demonstrate their ability to excel in competitive environments.\"\n      },\n      \"Certifications\": {\n        \"data\": [\n          \"List certifications in order of relevance to the job role.\",\n          \"Include any ongoing courses or certifications.\",\n          \"Provide details on the subjects covered in certifications.\"\n        ],\n        \"whyThisMatter\": \"Relevant certifications can validate skills and knowledge, making the candidate more appealing.\"\n      }\n    },\n    \"Overall Recommendations\": {\n      \"Formatting\": {\n        \"data\": [\n          \"Ensure consistent font style and size throughout.\",\n          \"Use bullet points for clarity and readability.\",\n          \"Maintain uniform margins and spacing.\"\n        ],\n        \"whyThisMatter\": \"Professional formatting enhances readability and creates a polished impression.\"\n      },\n      \"Tailoring\": {\n        \"data\": [\n          \"Customize the resume for each application, emphasizing relevant experiences.\",\n          \"Use keywords from the job description to align with ATS.\",\n          \"Highlight skills and experiences that match Google's core values.\"\n        ],\n        \"whyThisMatter\": \"Tailoring the resume increases the chances of passing ATS filters and resonates with hiring managers.\"\n      },\n      \"Proofreading\": {\n        \"data\": [\n          \"Check for grammatical errors and typos.\",\n          \"Ensure consistent use of technical terms.\",\n          \"Review for clarity and conciseness.\"\n        ],\n        \"whyThisMatter\": \"Proofreading eliminates distractions and maintains a professional appearance.\"\n      }\n    }\n  }\n}""''';

      var response = await request.send();

      var responseBody = await response.stream.bytesToString();

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: $responseBody');

      final responseBodyClean = responseBody.trim();

      final dynamic firstDecode = jsonDecode(responseBodyClean);

      final Map<String, dynamic> jsonDataLite =
          firstDecode is String ? jsonDecode(firstDecode) : firstDecode;

      return FileUploadResponse. fromJson(jsonDataLite);
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }
}
