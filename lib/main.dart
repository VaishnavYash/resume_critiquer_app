import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/digital/device.dart';
import 'package:resume_critiquer_app/framework/theme/theme.dart';
import 'package:resume_critiquer_app/view/history_page.dart';
import 'package:resume_critiquer_app/view/landing_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,

      themeMode: ThemeMode.dark,

      builder: (context, child) {
        Device.init(context);
        return child!;
      },

      home: const HistoryPage(),
    );
  }
}
