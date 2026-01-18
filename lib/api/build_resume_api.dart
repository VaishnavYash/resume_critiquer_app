import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
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
      "urls": [
        "https://github.com/VaishnavYash"
      ],
      "location": "",
      "designation": "Bachelor of Technology in Electrical Engineering"
    },
    "summary": "Detail-oriented Mobile Application Developer with a strong focus on building consumer-facing apps. Proficient in developing new features, optimizing performance, and collaborating effectively with cross-functional teams to deliver scalable solutions. Experienced in creating reusable UI components and implementing clean architecture principles.",
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
          "Optimized API consumption through Retrofit and Coroutines, enhancing load times and error resiliency.",
          "Executed in-depth debugging using ADB, Android Profiler, and LeakCanary, effectively identifying and resolving memory leaks and performance bottlenecks.",
          "Collaborated with cross-functional teams, including designers, product managers, and backend engineers, to streamline deployment and feature rollout in an Agile environment."
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
          "Developed and trained models utilizing BERT and RoBERTa, achieving a 15% improvement in classification accuracy.",
          "Conducted training and evaluation of models over 1,000+ epochs, optimizing performance and retrieval time."
        ],
        "location": ""
      }
    ],
    "projects": [
      {
        "name": "Resume Critiquer App",
        "description": [
          "Developed an AI-powered resume analysis platform leveraging Python and OpenAI APIs to deliver ATS-optimized feedback.",
          "Implemented NLP techniques to evaluate resume structure, keyword relevance, and content clarity, enhancing user experience.",
          "Created a cross-platform Flutter frontend for seamless resume uploads and real-time feedback, improving consumer-facing app functionality.",
          "Containerized backend services with Docker for consistent deployment and environment isolation, ensuring scalable solutions.",
          "Deployed and scaled the application on Google Cloud Platform (GCP) with secure API integration, optimizing performance.",
          "Aligned recommendations with ATS parsing rules to improve resume screening accuracy and user satisfaction."
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
          "Engineered a full-featured weather app utilizing Dart and Flutter with dynamic UI updates and real-time API integration.",
          "Supported over 250,000 city locations through Geocoder and WeatherAPI, enhancing user accessibility.",
          "Reduced crash rates by 80% through performance optimization and state management improvements.",
          "Implemented clean architecture and reusable UI components for maintainability and scalability."
        ],
        "url": "https://github.com/VaishnavYash/weather_forecast_flutter",
        "tools": [
          "Dart",
          "Flutter",
          "Rest APIs",
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
      "languages": [
        "Kotlin",
        "Java",
        "Dart",
        "Python"
      ],
      "android_skills": [
        "Android SDK",
        "Retrofit",
        "Material Design",
        "MVVM",
        "Git",
        "CI/CD"
      ],
      "tools_technologies": [
        "Android Studio",
        "Flutter",
        "GitHub",
        "Postman"
      ],
      "databases": [
        "SQLite"
      ]
    },
    "achievement": [
      "Elected Member of Students’ Legislative Council, demonstrating leadership and responsibility.",
      "Solved over 1200 coding challenges across platforms including Leetcode (610), GeeksforGeeks (600), Codeforces, and Codechef.",
      "Achieved a global rank of 4500 in Google Kick Start 2022.",
      "Completed certifications in Android Development, Data Structures and Algorithms, Power-BI, and SQL."
    ]
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
