import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:resume_critiquer_app/framework/digital/device.dart';
import 'package:resume_critiquer_app/framework/theme/theme.dart';
import 'package:resume_critiquer_app/model/file_upload/file_upload_hive.dart';
import 'package:resume_critiquer_app/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(FileUploadHiveAdapter());
  await Hive.openBox<FileUploadATSHive>('fileUploadBox');
  await Hive.openBox<FileUploadATSHive>('newResumeBox');

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

      home: const LandingPage(),
    );
  }
}
