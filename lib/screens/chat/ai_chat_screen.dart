import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_talk/services/speech_service.dart';
import 'dart:typed_data';
import 'package:record/record.dart';
import 'dart:io';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isListening = false;
  bool _isLoading = false;
  bool _isOffline = false;
  // Note: In a production app, this API key should be stored securely
  // and not hardcoded in the source code. Consider using environment variables
  // or a backend server to handle API calls.
  final String _apiKey = 'AIzaSyBgM0LutJvHpPJwMOdFTiMdnNYiMJYH2sA';
  final AudioPlayer _audioPlayer = AudioPlayer();
  final SpeechService _speechService = SpeechService();
  int? _playingIndex;
  bool _isTtsLoading = false;
  bool _isSttLoading = false;
  final AudioRecorder _recorder = AudioRecorder();
  String? _recordedPath;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isOffline = connectivityResult == ConnectivityResult.none;
    });

    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      setState(() {
        _isOffline = results.contains(ConnectivityResult.none);
      });
    });
  }

  Future<String> _getAIResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': message}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Microphone permission is required!')),
      );
      return;
    }
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.wav), // Use wav for STT
      path: 'audio_${DateTime.now().millisecondsSinceEpoch}.wav',
    );
  }

  Future<String?> stopRecording() async {
    final path = await _recorder.stop();
    return path;
  }

  Future<void> _startListening() async {
    setState(() {
      _isListening = true;
      _isSttLoading = true;
    });
    try {
      await startRecording();
    } catch (e) {
      setState(() {
        _isListening = false;
        _isSttLoading = false;
      });
    }
  }

  Future<void> _stopListening() async {
    setState(() {
      _isListening = false;
    });
    try {
      final path = await stopRecording();
      if (path != null) {
        final file = File(path);
        final audioBytes = await file.readAsBytes();
        final recognizedText = await _speechService.speechToText(audioBytes);
        if (recognizedText != null && recognizedText.isNotEmpty) {
          _messageController.text = recognizedText;
        }
      }
    } catch (e) {
      // Optionally show error
    } finally {
      setState(() {
        _isSttLoading = false;
      });
    }
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
      _isLoading = true;
    });

    final response = await _getAIResponse(text);

    if (mounted) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: response,
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
    }
  }

  Future<void> _playTts(ChatMessage message, int index) async {
    setState(() {
      _playingIndex = index;
      _isTtsLoading = true;
    });
    try {
      final audioBytes = await _speechService.textToSpeech(message.text);
      if (audioBytes != null) {
        await _audioPlayer.play(BytesSource(Uint8List.fromList(audioBytes)));
      }
    } catch (e) {
      // Optionally show error
    } finally {
      setState(() {
        _playingIndex = null;
        _isTtsLoading = false;
      });
    }
  }

  void _onMicPressed() async {
    if (_isListening) {
      print('Stopping recording...');
      await _stopListening();
    } else {
      print('Starting recording...');
      await _startListening();
    }
    setState(() {
      _isListening = !_isListening;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // TODO: Show help dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isOffline)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'No internet connection',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          if (_isSttLoading) const LinearProgressIndicator(minHeight: 2),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _ChatBubble(
                  message: message,
                  onPlay:
                      message.isUser ? null : () => _playTts(message, index),
                  isPlaying: _playingIndex == index && _isTtsLoading,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening ? Colors.red : null,
                  ),
                  onPressed: _isOffline ? null : _onMicPressed,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    enabled: !_isOffline,
                    decoration: InputDecoration(
                      hintText: _isOffline
                          ? 'Offline - No internet connection'
                          : 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  onPressed:
                      _isOffline ? null : (_isLoading ? null : _sendMessage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onPlay;
  final bool isPlaying;

  const _ChatBubble({
    required this.message,
    this.onPlay,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : null,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 12,
                    color: message.isUser
                        ? Colors.white.withOpacity(0.7)
                        : Colors.grey[600],
                  ),
                ),
                if (!message.isUser && onPlay != null) ...[
                  const SizedBox(width: 8),
                  isPlaying
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : IconButton(
                          icon: const Icon(Icons.play_arrow, size: 20),
                          onPressed: onPlay,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                        ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
