import 'dart:convert';
import 'dart:io';

import 'package:resume_critiquer_app/model/file_response_error.dart';
import 'package:resume_critiquer_app/model/build_resume_model.dart';

class BuildResumeApi {
  Future<BuildResumeModelResponse> fileUploadMultipart({
    required final File file,
    required final String jobTtile,
  }) async {
    // var uri = Uri.parse(
    //   'https://resume-critique-backend-513240140256.asia-south1.run.app/analyze_resume_pdf',
    // );
    // 'http://192.168.1.6:8080/analyze_resume_pdf',
    // 'http://localhost:8080/analyze_resume_pdf',

    // var request =
    //     http.MultipartRequest('POST', uri)
    //       ..fields['job_role'] = jobTtile
    //       ..files.add(await http.MultipartFile.fromPath('resume', file.path));

    // var response = await request.send();
    // var responseBody = await response.stream.bytesToString();

    // debugPrint('Response status: ${response.statusCode}');
    // debugPrint('Response body: $responseBody');

    final data = '''{
"status":"success",
"content" :
{
  "summary": "Results-driven Mobile Application Developer with expertise in Kotlin, Java, and Flutter. Experienced in developing consumer-facing apps, building secure and scalable solutions using RESTful services and APIs. Proven track record in improving performance, fixing bugs, and collaborating with designers, product managers, and backend engineers to enhance mobile application features.",
  "education": [
    {
      "institution": "indian institute of technology (iit) ropar",
      "degree": "b.tech.",
      "domain": "electrical engineering",
      "from": "december 2020",
      "to": "june 2024",
      "cgpa": ""
    }
  ],
  "experience": [
    {
      "company": "Tata Consultancy Services (TCS)",
      "role": "System Engineer (Innovator)",
      "from": "August 2024",
      "to": "Present",
      "topic": "",
      "bullets": [
        "Developed and improved consumer-facing features for the SBI YONO mobile app (10M+ users), enhancing performance and user experience.",
        "Built reusable UI components adhering to Material Design 3, reducing UI development time by 30%.",
        "Achieved 80% unit test coverage across service layers and state management, enhancing system reliability and stability.",
        "Optimized API consumption using Retrofit and Coroutines, reducing load time and improving error resiliency.",
        "Performed in-depth debugging with ADB, Android Profiler, and LeakCanary, identifying and resolving memory leaks and performance bottlenecks.",
        "Collaborated with cross-functional teams, including designers and product managers, to streamline deployment and feature rollout in an Agile environment."
      ]
    },
    {
      "company": "Indian Institute of Technology Indore",
      "role": "Guide - Dr. Nagendra Kumar",
      "from": "May 2023",
      "to": "July 2023",
      "topic": "Disaster Management Using Deep Learning Techniques",
      "bullets": [
        "Processed 10,000+ tweets for real-time disaster classification using NLP.",
        "Developed models using BERT and RoBERTa, improving classification accuracy by 15%.",
        "Trained and evaluated models over 1,000+ epochs, optimizing performance and retrieval time."
      ]
    }
  ],
  "projects": [
    {
      "name": "Resume Critiquer App",
      "description": [
        "Engineered an AI-powered resume analysis platform using Python and OpenAI APIs for ATS-optimized feedback.",
        "Implemented NLP-based evaluation to assess resume structure, keyword relevance, and content clarity, improving performance.",
        "Developed a cross-platform Flutter frontend enabling resume upload and real-time feedback delivery, enhancing user experience.",
        "Containerized backend services using Docker for consistent deployment and environment isolation.",
        "Deployed and scaled the application on Google Cloud Platform (GCP) with secure API integration, ensuring scalable solutions."
      ],
      "tools": [
        "Python",
        "OpenAI API",
        "Flutter",
        "Docker",
        "Google Cloud Platform",
        "Git"
      ]
    },
    {
      "name": "Weather Forecast App",
      "description": [
        "Built a full-featured weather app with dynamic UI updates and real-time API integration, focusing on consumer-facing apps.",
        "Supported 250,000+ city locations using Geocoder and WeatherAPI, enhancing functionality.",
        "Reduced crash rates by 80% through state management improvements, optimizing performance.",
        "Implemented dependency injection and clean architecture for maintainability and reusable UI components."
      ],
      "tools": [
        "Dart",
        "Flutter",
        "REST APIs",
        "JSON Syntax",
        "MobX",
        "SQLite",
        "Git"
      ]
    }
  ],
  "skills": [
    "Kotlin",
    "Java",
    "Dart",
    "C++",
    "Python",
    "SQL",
    "Android SDK",
    "Fragments",
    "Retrofit",
    "HTTP",
    "Gson",
    "RecyclerView",
    "Material Design",
    "MVVM",
    "Navigation Component",
    "Git",
    "CI/CD",
    "MobX",
    "Get-It",
    "GoRouter",
    "Provider",
    "Block",
    "Android Studio",
    "Flutter",
    "GitHub",
    "GitLab",
    "Postman",
    "SQLite",
    "Room",
    "PostgreSQL"
  ],
  "achievement": []
}}''';

    Map<String, dynamic> jsonData;
    // try {
    jsonData = jsonDecode(data) as Map<String, dynamic>;
    // } catch (e) {
    //   throw ApiException(
    //     code: 'INVALID_RESPONSE',
    //     message: 'Server returned an invalid response',
    //   );
    // }

    // if (response.statusCode >= 200 && response.statusCode < 300) {
    final content = jsonData['content'];

    final decodedContent = content is String ? jsonDecode(content) : content;

    return BuildResumeModelResponse(
      status: jsonData['status'],
      content: BuildResumeContent.fromJson(decodedContent),
    );
    // } else {
    //   final detail = jsonData['detail'];

    //   if (detail is Map<String, dynamic>) {
    //     throw ApiException(
    //       code: detail['code'] ?? 'UNKNOWN_ERROR',
    //       message: detail['message'] ?? 'Something went wrong',
    //     );
    //   } else {
    //     throw ApiException(
    //       code: 'UNKNOWN_ERROR',
    //       message: detail?.toString() ?? 'Something went wrong',
    //     );
    //   }
    // }
  }

  // Future<File> downloadPdf(Uint8List pdfContent) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/resume_analysis.pdf');

  //   await file.writeAsBytes(pdfContent, flush: true);
  //   return file;
  // }
}
