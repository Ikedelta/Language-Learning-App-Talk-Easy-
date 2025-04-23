import 'package:flutter/material.dart';
import 'package:easy_talk/screens/splash/splash_screen.dart';
import 'package:easy_talk/screens/language_courses/language_courses_screen.dart';
import 'package:easy_talk/screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Talk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/language-courses': (context) => const LanguageCoursesScreen(language: 'English'),
      },
    );
  }
}


