import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
  
  static const String geminiBaseUrl = 'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent';
  
  static const Duration apiTimeout = Duration(seconds: 60);
  
  static bool get isGeminiConfigured => geminiApiKey.isNotEmpty;
  
  static Map<String, String> get geminiHeaders => {
    'Content-Type': 'application/json',
    'x-goog-api-key': geminiApiKey,
  };
} 