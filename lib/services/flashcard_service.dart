import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_talk/models/flashcard.dart';
import 'package:easy_talk/services/logger_service.dart';
import 'package:easy_talk/config/api_config.dart';
import 'package:easy_talk/utils/logger.dart';

class FlashcardService {
  Future<List<Flashcard>> generateFlashcards({
    required String language,
    required String level,
    required String mode,
  }) async {
    try {
      if (!ApiConfig.isGeminiConfigured) {
        throw Exception('Gemini API key not configured. Please check your .env file.');
      }

      if (mode != 'flashcards') {
        throw ArgumentError('Currently only "flashcards" mode is supported');
      }

      final prompt = '''
Generate 10 flashcards for learning $language at the $level level. 
Format the response as a JSON array with the following structure for each flashcard:
{
  "word": "the word in $language",
  "translation": "English translation",
  "pronunciation": "pronunciation guide"
}
Make sure the response is valid JSON and includes exactly 10 items.
''';

      final response = await http.post(
        Uri.parse(ApiConfig.geminiBaseUrl),
        headers: ApiConfig.geminiHeaders,
        body: jsonEncode({
          'contents': [{
            'parts': [{
              'text': prompt
            }]
          }],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          },
        }),
      ).timeout(
        ApiConfig.apiTimeout,
        onTimeout: () {
          throw Exception('Request timed out. Please check your internet connection and try again.');
        },
      );

      if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception('Invalid or expired API key. Please check your API key configuration.');
      }

      if (response.statusCode == 429) {
        throw Exception('API rate limit exceeded. Please try again later.');
      }

      if (response.statusCode != 200) {
        throw Exception('Failed to generate flashcards: ${response.body}');
      }

      final jsonResponse = jsonDecode(response.body);
      final text = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
      final List<dynamic> flashcardsData = jsonDecode(text);

      return flashcardsData.map((data) => Flashcard(
        word: data['word'],
        translation: data['translation'],
        pronunciation: data['pronunciation'],
      )).toList();
    } catch (e) {
      AppLogger.error('Error generating flashcards', e);
      rethrow;
    }
  }

  List<Flashcard> _parseTextResponse(String text) {
    final List<Flashcard> flashcards = [];
    
    // Regular expression to match word, translation, and pronunciation
    final regex = RegExp(
      r'(?:Word|Term):\s*"?([^"\n]+)"?\s*'
      r'(?:Translation|English):\s*"?([^"\n]+)"?\s*'
      r'Pronunciation:\s*"?([^"\n]+)"?',
      multiLine: true,
    );

    final matches = regex.allMatches(text);
    
    for (final match in matches) {
      if (match.groupCount >= 3) {
        flashcards.add(Flashcard(
          word: match.group(1)?.trim() ?? '',
          translation: match.group(2)?.trim() ?? '',
          pronunciation: match.group(3)?.trim() ?? '',
        ));
      }
    }

    if (flashcards.isEmpty) {
      throw FormatException('Could not parse flashcards from response: $text');
    }

    return flashcards;
  }

  // Helper method to validate the response format
  bool _isValidFlashcardJson(Map<String, dynamic> json) {
    return json.containsKey('word') &&
        json.containsKey('translation') &&
        json.containsKey('pronunciation') &&
        json['word'] is String &&
        json['translation'] is String &&
        json['pronunciation'] is String;
  }
} 