import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/digital/device.dart';
import 'package:resume_critiquer_app/framework/theme/theme.dart';
import 'package:resume_critiquer_app/landing_page/view/landing_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    Device.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme, // Light Theme
      themeMode: ThemeMode.dark, // System Theme
      darkTheme: TAppTheme.darkTheme, // Dark Theme
      home: LandingPage(),
    );
  }
}
