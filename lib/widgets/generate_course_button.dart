import 'package:flutter/material.dart';
import 'package:easy_talk/services/course_service.dart';
import 'package:easy_talk/utils/logger.dart';

class GenerateCourseButton extends StatefulWidget {
  final String userId;
  final String language;
  final String level;
  final Function(String) onSuccess;
  final Function(String) onError;

  const GenerateCourseButton({
    Key? key,
    required this.userId,
    required this.language,
    required this.level,
    required this.onSuccess,
    required this.onError,
  }) : super(key: key);

  @override
  State<GenerateCourseButton> createState() => _GenerateCourseButtonState();
}

class _GenerateCourseButtonState extends State<GenerateCourseButton> {
  bool _isLoading = false;
  final _courseService = CourseService();

  Future<void> _generateCourse() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Check for existing courses
      final hasExisting = await _courseService.hasExistingCourse(
        widget.userId,
        widget.language,
      );

      if (hasExisting) {
        widget.onError('Course already exists. Please continue learning.');
        return;
      }

      // Generate new course
      final course = await _courseService.generateCourse(
        userId: widget.userId,
        language: widget.language,
        level: widget.level,
      );

      widget.onSuccess('Course generated successfully!');
      AppLogger.info('Generated course with ID: ${course.id}');
    } catch (e) {
      AppLogger.error('Error generating course', e);
      widget.onError(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _generateCourse,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      child: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text(
              'Generate Course with AI',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
} 