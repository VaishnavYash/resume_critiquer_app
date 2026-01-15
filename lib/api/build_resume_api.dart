import 'dart:convert';
import 'dart:io';

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
  "status": "success",
  "content": {
    "summary": "Mobile Application Developer with expertise in Flutter and Dart, specializing in developing consumer-facing apps and enhancing user experiences. Proven track record in building reusable UI components, optimizing performance through clean architecture, and collaborating effectively with cross-functional teams to deliver scalable solutions. Skilled in integrating RESTful APIs and ensuring application reliability through comprehensive testing and debugging.",
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
          "Developed and enhanced features for the consumer-facing SBI YONO mobile app, serving over 10 million users, with a focus on improving performance and user experience.",
          "Implemented reusable UI components adhering to Material Design 3 principles, resulting in a 30% reduction in UI development time.",
          "Achieved 80% unit test coverage across service layers and state management, significantly enhancing system reliability and stability.",
          "Optimized API consumption using Retrofit and Coroutines, leading to reduced load times and improved error resiliency.",
          "Conducted thorough debugging using ADB, Android Profiler, and LeakCanary, successfully identifying and resolving memory leaks and performance bottlenecks.",
          "Collaborated with cross-functional teams, including designers, product managers, and backend engineers, to streamline deployment and feature rollout in an agile environment."
        ],
        "location": "Pune"
      },
      {
        "company": "Indian Institute of Technology Indore",
        "role": "Guide - Dr. Nagendra Kumar",
        "from": "May 2023",
        "to": "July 2023",
        "topic": "Disaster Management Using Deep Learning Techniques",
        "bullets": [
          "Processed over 10,000 tweets for real-time disaster classification using NLP techniques.",
          "Developed and fine-tuned models utilizing BERT and RoBERTa, achieving a 15% improvement in classification accuracy.",
          "Trained and evaluated models over 1,000 epochs, optimizing performance and retrieval times."
        ],
        "location": ""
      }
    ],
    "projects": [
      {
        "name": "Resume Critiquer App",
        "description": [
          "Developed an AI-powered resume analysis platform utilizing Python and OpenAI APIs to deliver ATS-optimized feedback.",
          "Implemented NLP-based evaluation techniques to enhance resume structure, keyword relevance, and content clarity.",
          "Created a cross-platform Flutter frontend for seamless resume uploads and real-time feedback delivery.",
          "Containerized backend services with Docker to ensure consistent deployment and environment isolation.",
          "Deployed and scaled the application on Google Cloud Platform (GCP), ensuring secure API integration and performance optimization.",
          "Aligned recommendations with ATS parsing rules to improve resume screening accuracy."
        ],
        "tools": [
          "Python",
          "OpenAI API",
          "Flutter",
          "Docker",
          "Google Cloud Platform",
          "GitHub"
        ],
        "location": ""
      },
      {
        "name": "Weather Forecast App",
        "description": [
          "Engineered a full-featured weather application with dynamic UI updates and real-time API integration.",
          "Supported over 250,000 city locations through effective use of geocoding and weather APIs.",
          "Reduced crash rates by 80% through performance optimization and state management improvements.",
          "Implemented clean architecture and dependency injection to enhance maintainability and facilitate collaboration with backend engineers."
        ],
        "tools": [
          "Dart",
          "Flutter",
          "REST APIs",
          "JSON Syntax",
          "MobX",
          "SQLite",
          "GitHub"
        ],
        "location": ""
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
        "Retrofit",
        "Gson",
        "SQLite"
      ],
      "tools_technologies": [
        "Android Studio",
        "Flutter",
        "Git",
        "GitLab",
        "Postman"
      ],
      "databases": [
        "Room",
        "PostgreSQL"
      ]
    },
    "achievement": [
      "Elected member of the Students’ Legislative Council 2024, demonstrating leadership and responsibility.",
      "Successfully solved over 1200 coding challenges across platforms including LeetCode (610), GeeksforGeeks (600), Codeforces, and CodeChef, showcasing strong problem-solving skills.",    
      "Achieved a global rank of 4500 in Google Kick Start 2022, reflecting competitive programming proficiency.",
      "Completed certifications in Android Development, Data Structures and Algorithms, Power BI, and SQL, enhancing technical expertise relevant to mobile application development."
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
}
