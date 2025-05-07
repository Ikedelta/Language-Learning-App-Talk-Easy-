import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _apiKey =
      'YOUR_OPENAI_API_KEY'; // Replace with your OpenAI API key

  Future<List<Map<String, dynamic>>> getChatHistory(
    String userId,
    String language,
    String level,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc('${language}_$level')
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error getting chat history: $e');
      return [];
    }
  }

  Future<String> sendMessage({
    required String userId,
    required String message,
    required String language,
    required String level,
  }) async {
    try {
      // Save user message
      await _saveMessage(
        userId: userId,
        message: message,
        isUser: true,
        language: language,
        level: level,
      );

      // Get AI response
      final response = await _getAIResponse(
        message: message,
        language: language,
        level: level,
      );

      // Save AI response
      await _saveMessage(
        userId: userId,
        message: response,
        isUser: false,
        language: language,
        level: level,
      );

      return response;
    } catch (e) {
      print('Error sending message: $e');
      rethrow;
    }
  }

  Future<void> _saveMessage({
    required String userId,
    required String message,
    required bool isUser,
    required String language,
    required String level,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc('${language}_$level')
          .collection('messages')
          .add({
        'text': message,
        'isUser': isUser,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving message: $e');
      rethrow;
    }
  }

  Future<String> _getAIResponse({
    required String message,
    required String language,
    required String level,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a language tutor for $language at $level level. Help the user practice $language by engaging in conversation. Correct their mistakes and provide explanations when needed.',
            },
            {
              'role': 'user',
              'content': message,
            },
          ],
          'temperature': 0.7,
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to get AI response');
      }
    } catch (e) {
      print('Error getting AI response: $e');
      return 'Sorry, I encountered an error. Please try again.';
    }
  }
}
