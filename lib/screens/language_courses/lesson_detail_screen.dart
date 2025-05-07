import 'package:flutter/material.dart';
import 'package:easy_talk/models/course_level.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import '../../services/course_progress_service.dart';
import 'quiz_screen.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;
  final String courseId;

  const LessonDetailScreen({
    super.key,
    required this.lesson,
    required this.courseId,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late VideoPlayerController _videoController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  final bool _hasError = false;
  String? _errorMessage;
  final bool _isVideoInitialized = false;
  double _lessonProgress = 0.0;
  final CourseProgressService _progressService = CourseProgressService();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.lesson.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
    _setupAudioPlayer();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final progress = await _progressService.getLessonProgress(widget.lesson.id);
    setState(() {
      _lessonProgress = progress;
    });
  }

  Future<void> _updateProgress(double progress) async {
    if (progress > _lessonProgress) {
      await _progressService.updateLessonProgress(widget.lesson.id, progress);
      await _updateCourseProgress();
      setState(() {
        _lessonProgress = progress;
      });
    }
  }

  Future<void> _updateCourseProgress() async {
    final totalLessons = 2; // This should be dynamic based on the course
    final currentProgress =
        await _progressService.getCourseProgress(widget.courseId);
    final newProgress = (_lessonProgress + currentProgress) / totalLessons;
    await _progressService.updateCourseProgress(widget.courseId, newProgress);
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    } else {
      await _audioPlayer.play(AssetSource(widget.lesson.audioUrl));
      setState(() => _isPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.lesson.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            if (_videoController.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_videoController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      if (_videoController.value.isPlaying) {
                        _videoController.pause();
                      } else {
                        _videoController.play();
                      }
                    });
                  },
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.stop : Icons.volume_up),
                  onPressed: _playAudio,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Vocabulary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.lesson.vocabulary
                  .map((word) => Chip(label: Text(word)))
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Grammar Points',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...widget.lesson.grammarPoints.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('• $point'),
                )),
            const SizedBox(height: 24),
            Text(
              'Exercises',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...widget.lesson.exercises.map((exercise) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('• $exercise'),
                )),
            const SizedBox(height: 24),
            Text(
              'Notes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(widget.lesson.notes),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      lessonId: widget.lesson.id,
                      language:
                          'english', // You should pass the actual language
                      levelId: widget.courseId,
                    ),
                  ),
                );
              },
              child: const Text('Take Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
