import 'package:flutter/material.dart';
import 'package:easy_talk/screens/splash/splash_screen.dart';
import 'package:easy_talk/screens/language_courses/language_courses_screen.dart';
import 'package:easy_talk/screens/auth/login_screen.dart';
import 'package:easy_talk/screens/auth/signup_screen.dart';
import 'package:easy_talk/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Talk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(toggleTheme: toggleTheme),
      routes: {
        '/login': (context) => LoginScreen(toggleTheme: toggleTheme),
        '/home': (context) => HomeScreen(toggleTheme: toggleTheme),
        '/signup': (context) => SignupScreen(toggleTheme: toggleTheme),
        '/language-courses': (context) =>
            const LanguageCoursesScreen(language: 'English'),
      },
    );
  }
}
