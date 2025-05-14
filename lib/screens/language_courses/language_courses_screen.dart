import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/course_level.dart';
import '../../services/theme_service.dart';
import '../../services/course_service.dart';
import 'course_detail_screen.dart';
import '../../services/auth_service.dart';
import '../../providers/course_provider.dart';
import '../../config/api_config.dart';

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
  bool _isGenerating = false;
  final AuthService _authService = AuthService();
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserProgress();
    _loadCourses();
  }

  Future<void> _loadUserProgress() async {
    try {
      final userId = _authService.currentUser?.uid;
      if (userId != null) {
        final progress = await _courseService.getUserProgress(
          userId,
          widget.language,
        );
        setState(() {
          _userProgress = progress;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCourses() async {
    try {
      final courseProvider = context.read<CourseProvider>();
      print('Loading courses for language: ${widget.language}');
      await courseProvider.loadCoursesByLanguage(widget.language);
      print('Courses loaded. Total courses: ${courseProvider.courses.length}');
      
      if (courseProvider.courses.isEmpty) {
        print('No courses found. Checking for errors: ${courseProvider.error}');
      } else {
        print('First course: ${courseProvider.courses.first.title}');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
      print('Error in _loadCourses: $e');
    }
  }

  Future<void> _generateCourse() async {
    final courseProvider = context.read<CourseProvider>();
    final userId = _authService.currentUser?.uid;
    
    if (userId == null) {
      setState(() {
        _error = 'Please sign in to generate courses';
      });
      return;
    }

    setState(() {
      _isGenerating = true;
      _error = null;
    });

    try {
      print('Generating course for language: ${widget.language}, level: ${widget.level}');
      print('API Key configured: ${ApiConfig.isGeminiConfigured}');
      
      await courseProvider.generateCourse(
        language: widget.language,
        level: widget.level,
        userId: userId,
      );

      // Reload courses after successful generation
      await _loadCourses();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Course generated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Error generating course: $e');
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate course: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.language} Courses - ${widget.level}'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isGenerating ? null : _generateCourse,
        label: Text(_isGenerating ? 'Generating...' : 'Generate with AI'),
        icon: Icon(_isGenerating ? Icons.hourglass_empty : Icons.auto_awesome),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<CourseProvider>(
      builder: (context, courseProvider, child) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: $_error',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _error = null;
                      _isLoading = true;
                    });
                    _loadCourses();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final courses = courseProvider.courses;
        if (courses.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No courses available yet',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Click the button below to generate a new course',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(course.name),
                subtitle: Text(course.description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailScreen(
                        courseId: course.id,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
