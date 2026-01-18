import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:resume_critiquer_app/model/build_resume/build_resume_model.dart';
import 'package:resume_critiquer_app/model/other/file_response_error.dart';

class BuildResumeApi {
  Future<BuildResumeModelResponse> fileUploadMultipart({
    required final File file,
    required final String jobTtile,
  }) async {
    var uri = Uri.parse(
      'https://resume-critique-backend-513240140256.asia-south1.run.app/get_pdf_data',
    );
      // 'http://192.168.1.6:8000/get_pdf_data',

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

      return BuildResumeModelResponse(
        status: jsonData['status'],
        content: BuildResumeContent.fromJson(decodedContent),
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

  Future<void> savePdfToDownloads(Uint8List pdfBytes) async {
    final fileName = 'resume_${DateTime.now().millisecondsSinceEpoch}.pdf';

    const platform = MethodChannel('pdf_download');

    await platform.invokeMethod('savePdf', {
      'bytes': pdfBytes,
      'fileName': fileName,
    });

    OpenFilex.open('/storage/emulated/0/Download/$fileName');
  }
}

// final responseBody = '''{ "status": "success", "content": { "personal": { "name": "Yash Vaishnav", "email": "y01vaishnava@gmail.com", "phone": "+91-8769749999", "urls": [ "mailto:y01vaishnava@gmail.com", "https://github.com/VaishnavYash" ], "location": "", "designation": "Bachelor of Technology in Electrical Engineering" }, "summary": "Detail-oriented Developer with expertise in enhancing application performance and user experience. Proficient in building scalable solutions using Flutter and REST API, with a strong focus on stability and feature improvement. Adept at collaborating in Agile environments to deliver high-quality software solutions.", "education": [ { "institution": "Indian Institute of Technology (IIT) Ropar", "degree": "B.Tech.", "domain": "Electrical Engineering", "from": "December 2020", "to": "June 2024", "cgpa": "" } ], "experience": [ { "company": "Tata Consultancy Services (TCS)", "role": "System Engineer(Innovator)", "from": "August 2024", "to": "Present", "topic": "", "bullets": [ "Enhanced SBI YONO app features for 10M+ users, boosting performance and user experience.", "Developed reusable UI components, reducing UI development time by 30%.", "Achieved 80% unit test coverage, enhancing system stability and reliability.", "Optimized API consumption, improving load time and error resiliency.", "Collaborated in Agile teams to streamline app maintenance and feature rollout." ], "location": "Pune" }, { "company": "Indian Institute of Technology Indore", "role": "Guide - Dr. Nagendra Kumar | Topic - Disaster Management using Deep Learning Techniques", "from": "May 2023", "to": "July 2023", "topic": "", "bullets": [ "Processed 10,000+ tweets for real-time disaster classification using NLP techniques.", "Developed BERT and RoBERTa models, increasing classification accuracy by 15%.", "Trained models over 1,000+ epochs, optimizing performance and retrieval time." ], "location": "" } ], "projects": [ { "name": "Resume Critiquer App", "description": [ "Developed an AI-driven platform for ATS-optimized resume analysis and feedback.", "Implemented NLP techniques for evaluating resume structure and keyword relevance.", "Delivered a cross-platform Flutter frontend for seamless resume uploads and feedback.", "Optimized backend services with Docker for stability and consistent deployment.", "Deployed on Google Cloud Platform, ensuring secure API integration and performance." ], "url": "https://github.com/VaishnavYash/resume_critiquer_app", "tools": [ "Python", "OpenAI API", "Flutter", "Docker", "Google Cloud Platform" ], "location": "", "from": "Nov 2025", "to": "Dec 2025" }, { "name": "Weather Forecast App", "description": [ "Engineered a dynamic weather app with real-time API integration and analytics support.", "Supported 250,000+ city locations using Geocoder and WeatherAPI for data tracking.", "Improved app stability by reducing crash rates through state management enhancements.", "Implemented clean architecture for maintainability and feature improvement." ], "url": "https://github.com/VaishnavYash/weather_forecast_flutter", "tools": [ "Dart", "Flutter", "Rest API’s", "JSON Syntax", "Mobx", "SQLite" ], "location": "", "from": "Oct. 2024", "to": "Nov. 2024" } ], "skills": { "technical_skills": [ "Kotlin", "Java", "Dart", "Python", "SQL", "Android SDK", "REST API", "Material Design", "SQLite", "MobX" ], "tools_technologies": [ "Android Studio", "Flutter", "GitHub", "Postman" ], "databases": [ "SQLite", "Room", "PostgreSQL" ] }, "achievement": [ "Elected Member of Students’ Legislative Council, demonstrating leadership skills.", "Solved over 1200 coding challenges across multiple platforms.", "Achieved a global rank of 4500 in Google Kick Start.", "Completed certifications in Android Development, Data Structures, Power-BI, and SQL." ] } }''';
