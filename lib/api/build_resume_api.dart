import 'dart:convert';
import 'dart:io';

import 'package:resume_critiquer_app/model/build_resume/build_resume_model.dart';

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
  "status": "success",
  "content": {
    "personal": {
      "name": "Yash Vaishnav",
      "email": "yvaishnava.vaishnava@gmail.com",
      "phone": "+91-9413042232",
      "linkedin_url": "https://github.com/VaishnavYash",
      "github_url": "",
      "website": "",
      "location": "",
      "designation": "Bachelor of Technology in Electrical Engineering"
    },
    "summary": "Detail-oriented Mobile Application Developer with expertise in Flutter and Dart, focused on developing consumer-facing apps and improving performance through reusable UI components and clean architecture. Proven ability to optimize API integrations and collaborate effectively with cross-functional teams to deliver scalable solutions.",
    "education": [
      {
        "institution": "Indian Institute of Technology (IIT) Ropar",
        "degree": "B.Tech.",
        "domain": "Electrical Engineering",
        "from": "December 2020",
        "to": "June 2024",
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
          "Developed and enhanced consumer-facing features for the SBI YONO mobile app, serving over 10M users, with a focus on performance optimization and user experience.",
          "Implemented reusable UI components adhering to Material Design 3 principles, accelerating UI development by 30%.",
          "Achieved 80% unit test coverage across service layers and state management, significantly improving system reliability and stability.",
          "Optimized API consumption using Retrofit and Coroutines, enhancing load times and error resiliency.",
          "Conducted comprehensive debugging with ADB, Android Profiler, and LeakCanary, effectively identifying and resolving memory leaks and performance bottlenecks.",
          "Collaborated with cross-functional teams, including designers and product managers, to streamline deployment and feature rollout in an Agile environment."
        ],
        "location": "Pune"
      },
      {
        "company": "Indian Institute of Technology Indore",
        "role": "Guide - Dr. Nagendra Kumar",
        "from": "May 2023",
        "to": "July 2023",
        "topic": "Disaster Management using Deep Learning Techniques",
        "bullets": [
          "Processed over 10,000 tweets for real-time disaster classification using NLP techniques.",
          "Developed and fine-tuned models with BERT and RoBERTa, achieving a 15% improvement in classification accuracy.",
          "Trained and evaluated models across 1,000+ epochs, optimizing performance and retrieval time."
        ],
        "location": ""
      }
    ],
    "projects": [
      {
        "name": "Resume Critiquer App",
        "description": [
          "Developed an AI-driven resume analysis platform utilizing Python and OpenAI APIs to deliver ATS-optimized feedback.",
          "Implemented NLP techniques to evaluate resume structure, keyword relevance, and content clarity, enhancing user experience.",
          "Created a cross-platform Flutter frontend for seamless resume uploads and real-time feedback, improving consumer engagement.",
          "Containerized backend services with Docker to ensure consistent deployment and scalability across environments.",
          "Deployed and optimized the application on Google Cloud Platform (GCP), ensuring secure API integration and robust performance.",
          "Aligned recommendations with ATS parsing rules to significantly improve resume screening accuracy."
        ],
        "url": "https://github.com/VaishnavYash/resume_critiquer_app",
        "tools": [
          "Python",
          "OpenAI API",
          "Flutter",
          "Docker",
          "Google Cloud Platform"
        ],
        "location": "",
        "from": "Nov 2025",
        "to": "Dec 2025"
      },
      {
        "name": "Weather Forecast App",
        "description": [
          "Engineered a consumer-facing weather application with dynamic UI updates and real-time API integration using Dart and Flutter.",
          "Supported over 250,000 city locations through Geocoder and WeatherAPI, enhancing user accessibility.",
          "Achieved an 80% reduction in crash rates by optimizing state management and implementing clean architecture for maintainability.",
          "Utilized dependency injection to create reusable UI components, improving overall application performance and scalability."
        ],
        "url": "https://github.com/VaishnavYash/weather_forecast_flutter",
        "tools": [
          "Dart",
          "Flutter",
          "Rest API’s",
          "JSON Syntax",
          "Mobx",
          "SQLite"
        ],
        "location": "",
        "from": "Oct. 2024",
        "to": "Nov. 2024"
      }
    ],
    "skills": {
      "technical_skills": [
        "Kotlin",
        "Java",
        "Dart",
        "C++",
        "Python",
        "SQL",
        "Android SDK",
        "Fragments",
        "Retrofit",
        "Http"
      ],
      "tools_technologies": [
        "Android Studio",
        "Flutter",
        "GitHub",
        "GitLab",
        "Postman",
        "SQLite",
        "Room",
        "PostgreSQL"
      ]
    },
    "achievement": []
  }
}''';

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
