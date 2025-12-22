import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/digital/device.dart';
import 'package:resume_critiquer_app/main_page/view/pdf_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    Device.init(context);
    return const MaterialApp(
      home: Scaffold(body: SafeArea(child: PDFUploadPage())),
    );
  }
}
