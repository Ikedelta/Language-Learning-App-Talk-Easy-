import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/course_level.dart';
import '../../services/course_service.dart';
import '../../services/auth_service.dart';
import 'lesson_screen.dart';

class CourseLevelsScreen extends StatefulWidget {
  final String language;

  const CourseLevelsScreen({
    super.key,
    required this.language,
  });

  @override
  State<CourseLevelsScreen> createState() => _CourseLevelsScreenState();
}

class _CourseLevelsScreenState extends State<CourseLevelsScreen> {
  final CourseService _courseService = CourseService();
  final AuthService _authService = AuthService();
  List<CourseLevel> _levels = [];
  Map<String, dynamic> _userProgress = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  Future<void> _loadLevels() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final levels = await _courseService.getCourseLevels(widget.language);
        final progress = await _courseService.getUserProgress(
          user.uid,
          widget.language,
        );
        setState(() {
          _levels = levels;
          _userProgress = progress;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading levels: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  double _calculateProgress(CourseLevel level) {
    final completedLessons = _userProgress['completedLessons'] as List? ?? [];
    final levelLessons = level.lessons.map((l) => l.id).toList();
    final completedLevelLessons =
        completedLessons.where((id) => levelLessons.contains(id)).length;
    return completedLevelLessons / levelLessons.length;
  }

  bool _isLevelUnlocked(CourseLevel level) {
    if (level.level == 1) return true;
    final previousLevel = _levels.firstWhere(
      (l) => l.level == level.level - 1,
      orElse: () => level,
    );
    return _calculateProgress(previousLevel) >= 0.8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.language} Courses'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _levels.length,
              itemBuilder: (context, index) {
                final level = _levels[index];
                final isUnlocked = _isLevelUnlocked(level);
                final progress = _calculateProgress(level);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: isUnlocked
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LessonScreen(
                                  language: widget.language,
                                  level: level,
                                ),
                              ),
                            ).then((_) => _loadLevels());
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: isUnlocked
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${level.level}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      level.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      level.description,
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
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isUnlocked
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${(progress * 100).round()}% Complete',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              if (!isUnlocked)
                                Text(
                                  'Complete previous level to unlock',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.grey[600],
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
