import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/course_level.dart';
import '../../services/course_service.dart';
import '../../services/auth_service.dart';
import 'quiz_screen.dart';

class LessonScreen extends StatefulWidget {
  final String language;
  final CourseLevel level;

  const LessonScreen({
    super.key,
    required this.language,
    required this.level,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final CourseService _courseService = CourseService();
  final AuthService _authService = AuthService();
  Map<String, dynamic> _userProgress = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProgress();
  }

  Future<void> _loadUserProgress() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final progress = await _courseService.getUserProgress(
          user.uid,
          widget.language,
        );
        setState(() {
          _userProgress = progress;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading progress: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  bool _isLessonCompleted(String lessonId) {
    final completedLessons = _userProgress['completedLessons'] as List? ?? [];
    return completedLessons.contains(lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.name),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.level.lessons.length,
              itemBuilder: (context, index) {
                final lesson = widget.level.lessons[index];
                final isCompleted = _isLessonCompleted(lesson.id);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            lessonId: lesson.id,
                            language: widget.language,
                            levelId: widget.level.id,
                          ),
                        ),
                      ).then((_) => _loadUserProgress());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isCompleted
                                      ? Colors.green
                                      : Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    isCompleted
                                        ? Icons.check
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lesson.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      lesson.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${lesson.duration} min',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.school_outlined,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                lesson.difficulty,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                              const Spacer(),
                              if (isCompleted)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Completed',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
