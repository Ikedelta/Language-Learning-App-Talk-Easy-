import 'package:flutter/material.dart';
import '../../models/model_types.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import '../../services/course_progress_service.dart';
import 'quiz_screen.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;
  final String courseId;
  final String language;

  const LessonDetailScreen({
    super.key,
    required this.lesson,
    required this.courseId,
    required this.language,
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

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
            if (widget.lesson.dialogue != null) ...[
              const Text(
                'Dialogue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(widget.lesson.dialogue!),
                ),
              ),
              const SizedBox(height: 24),
            ],
            const Text(
              'Vocabulary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.lesson.vocabulary.length,
              itemBuilder: (context, index) {
                final vocab = widget.lesson.vocabulary[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(vocab.word),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Translation: ${vocab.translation}'),
                        Text('Pronunciation: ${vocab.pronunciation}'),
                      ],
                    ),
                  ),
                );
              },
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
                _updateProgress(1.0);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      lessonId: widget.lesson.id,
                      language: widget.language,
                      levelId: widget.courseId,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Take Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
