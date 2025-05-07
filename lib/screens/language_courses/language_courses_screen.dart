import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/course_level.dart';
import '../../services/theme_service.dart';
import '../../services/course_service.dart';
import 'course_detail_screen.dart';
import '../../services/auth_service.dart';

class LanguageCoursesScreen extends StatefulWidget {
  final String language;
  final String level;

  const LanguageCoursesScreen({
    Key? key,
    required this.language,
    required this.level,
  }) : super(key: key);

  @override
  State<LanguageCoursesScreen> createState() => _LanguageCoursesScreenState();
}

class _LanguageCoursesScreenState extends State<LanguageCoursesScreen> {
  final CourseService _courseService = CourseService();
  Map<String, dynamic>? _userProgress;
  bool _isLoading = true;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserProgress();
  }

  Future<void> _loadUserProgress() async {
    try {
      final user = Provider.of<AuthService>(context, listen: false).currentUser;
      if (user != null) {
        final progress =
            await _courseService.getUserProgress(user.uid, widget.language);
        setState(() {
          _userProgress = progress;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.language} Courses'),
        backgroundColor: theme.primaryColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<CourseLevel>>(
              stream: _courseService.getCoursesByLanguage(widget.language),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading courses',
                      style: theme.errorTextStyle,
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final courses = snapshot.data!;
                if (courses.isEmpty) {
                  return Center(
                    child: Text(
                      'No courses available',
                      style: theme.bodyStyle,
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final isEnrolled = _userProgress?['enrolledCourses']
                            ?.contains(course.id) ??
                        false;
                    final canEnroll = !course.isLocked &&
                        (_userProgress?['totalScore'] ?? 0) >=
                            course.requiredXp;

                    return _buildCourseCard(course);
                  },
                );
              },
            ),
    );
  }

  Widget _buildCourseCard(CourseLevel course) {
    final isEnrolled =
        _userProgress?['enrolledCourses']?.contains(course.id) ?? false;
    final completedLessons =
        List<String>.from(_userProgress?['completedLessons'] ?? []);
    final courseLessons = course.lessons;
    final completedLessonsCount = courseLessons
        .where((lesson) => completedLessons.contains(lesson.id))
        .length;
    final progress = courseLessons.isEmpty
        ? 0.0
        : completedLessonsCount / courseLessons.length;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Level: ${course.level}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (isEnrolled)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${(progress * 100).toInt()}% Complete',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              course.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${courseLessons.length} Lessons',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (!isEnrolled)
                  Text(
                    'Required XP: ${course.requiredXp}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (isEnrolled)
              LinearProgressIndicator(
                value: progress,
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (!isEnrolled) {
                  try {
                    final user = _authService.currentUser;
                    if (user != null) {
                      await _courseService.enrollInCourse(
                        user.uid,
                        widget.language,
                        course.id,
                      );
                      await _loadUserProgress();
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error enrolling in course: $e'),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  }
                } else {
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(
                          course: course,
                          userProgress: _userProgress,
                        ),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(isEnrolled ? 'Continue' : 'Enroll'),
            ),
          ],
        ),
      ),
    );
  }
}
