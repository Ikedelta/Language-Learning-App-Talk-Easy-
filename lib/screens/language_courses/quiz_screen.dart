import 'package:flutter/material.dart';
import '../../models/course_level.dart';
import '../../services/course_service.dart';
import '../../services/auth_service.dart';
import '../../models/model_types.dart';

class QuizScreen extends StatefulWidget {
  final String lessonId;
  final String language;
  final String levelId;

  const QuizScreen({
    super.key,
    required this.lessonId,
    required this.language,
    required this.levelId,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final CourseService _courseService = CourseService();
  final AuthService _authService = AuthService();
  Lesson? _lesson;
  bool _isLoading = true;
  int _currentExerciseIndex = 0;
  String? _selectedAnswer;
  bool _showExplanation = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _loadLesson();
  }

  Future<void> _loadLesson() async {
    try {
      final lesson = await _courseService.getLesson(
        widget.language,
        widget.levelId,
        widget.lessonId,
      );
      setState(() {
        _lesson = lesson;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading lesson: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  void _handleAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _showExplanation = true;
      if (answer == _currentExercise.correctAnswer) {
        _score++;
      }
    });
  }

  void _nextExercise() {
    if (_currentExerciseIndex < _lesson!.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _selectedAnswer = null;
        _showExplanation = false;
      });
    } else {
      _completeLesson();
    }
  }

  Future<void> _completeLesson() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        await _courseService.completeLesson(
          user.uid,
          widget.language,
          widget.levelId,
          widget.lessonId,
        );
        if (mounted) {
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error completing lesson: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Exercise get _currentExercise => _lesson!.exercises[_currentExerciseIndex];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_lesson == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Lesson not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_lesson!.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentExerciseIndex + 1) / _lesson!.exercises.length,
            ),
            const SizedBox(height: 16),
            Text(
              'Exercise ${_currentExerciseIndex + 1} of ${_lesson!.exercises.length}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Text(
              _currentExercise.question,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            ..._currentExercise.options.map((option) {
              final isSelected = option == _selectedAnswer;
              final isCorrect = option == _currentExercise.correctAnswer;
              final showResult = _showExplanation && isSelected;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed:
                      _showExplanation ? null : () => _handleAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showResult
                        ? isCorrect
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1)
                        : null,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(
                            color: showResult
                                ? isCorrect
                                    ? Colors.green
                                    : Colors.red
                                : null,
                          ),
                        ),
                      ),
                      if (showResult)
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                    ],
                  ),
                ),
              );
            }),
            if (_showExplanation) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explanation',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(_currentExercise.explanation),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _nextExercise,
                child: Text(
                  _currentExerciseIndex < _lesson!.exercises.length - 1
                      ? 'Next Exercise'
                      : 'Complete Lesson',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
