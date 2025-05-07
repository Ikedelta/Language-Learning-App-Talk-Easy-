import 'dart:convert';
import 'package:http/http.dart' as http;

class SpeechService {
  static const String apiKey = '9ce618bb075a7b3df93a3940c23c0cfb87d65e2c';

  /// Text-to-Speech: Sends text to the TTS API and returns the audio bytes.
  Future<List<int>?> textToSpeech(String text) async {
    // TODO: Replace with your actual TTS endpoint
    final url = Uri.parse('https://api.example.com/tts');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'text': text,
        // Add other parameters as needed
      }),
    );
    if (response.statusCode == 200) {
      // Assuming the API returns audio bytes directly
      return response.bodyBytes;
    } else {
      print('TTS Error: \\${response.statusCode} - \\${response.body}');
      return null;
    }
  }

  /// Speech-to-Text: Sends audio bytes to the STT API and returns the recognized text.
  Future<String?> speechToText(List<int> audioBytes) async {
    // TODO: Replace with your actual STT endpoint
    final url = Uri.parse('https://api.example.com/stt');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'audio/wav', // or the correct content type
      },
      body: audioBytes,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['text'] as String?;
    } else {
      print('STT Error: \\${response.statusCode} - \\${response.body}');
      return null;
    }
  }
}
