import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import '../../models/language_course.dart';

class LessonDetailScreen extends StatefulWidget {
  final CourseLesson lesson;

  const LessonDetailScreen({
    super.key,
    required this.lesson,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late YoutubePlayerController _controller;
  late String _videoId;
  final audio.AudioPlayer _audioPlayer = audio.AudioPlayer();
  bool _isPlaying = false;
  bool _hasError = false;
  String? _errorMessage;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == audio.PlayerState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  void _initializeVideo() {
    try {
      String url = widget.lesson.videoUrl;
      if (url.startsWith('https://youtu.be/')) {
        url = url.split('?')[0];
        _videoId = url.split('/').last;
      } else if (url.startsWith('https://www.youtube.com/')) {
        _videoId = YoutubePlayer.convertUrlToId(url) ?? '';
      } else {
        _videoId = '';
      }
      
      if (_videoId.isEmpty) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Invalid video URL';
          _isVideoInitialized = true;
        });
        return;
      }

      _controller = YoutubePlayerController(
        initialVideoId: _videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: true,
          hideControls: false,
        ),
      );

      _controller.addListener(() {
        if (_controller.value.hasError) {
          setState(() {
            _hasError = true;
            _errorMessage = 'Error playing video: ${_controller.value.errorCode}';
          });
        }
      });

      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Error initializing video: $e';
        _isVideoInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio() async {
    if (!widget.lesson.audioUrl.startsWith('assets/')) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Invalid audio file path';
      });
      return;
    }

    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(audio.AssetSource(widget.lesson.audioUrl));
      }
      setState(() {
        _isPlaying = !_isPlaying;
        _hasError = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Error playing audio: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        actions: [
          if (widget.lesson.audioUrl.isNotEmpty)
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle),
              onPressed: _toggleAudio,
              iconSize: 32,
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_hasError)
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.red[100],
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage ?? 'An error occurred',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            if (_isVideoInitialized && _videoId.isNotEmpty)
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.lesson.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.lesson.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Vocabulary',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.lesson.vocabulary
                        .map((word) => Chip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(word),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    icon: const Icon(Icons.volume_up, size: 18),
                                    onPressed: () async {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Pronunciation for "$word" coming soon!'),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Grammar Points',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...widget.lesson.grammarPoints.map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_outline, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(point)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 