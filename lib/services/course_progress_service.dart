import 'package:shared_preferences/shared_preferences.dart';

class CourseProgressService {
  static const String _progressPrefix = 'course_progress_';
  static const String _lessonProgressPrefix = 'lesson_progress_';

  Future<void> updateCourseProgress(String courseId, double progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$_progressPrefix$courseId', progress);
  }

  Future<double> getCourseProgress(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('$_progressPrefix$courseId') ?? 0.0;
  }

  Future<void> updateLessonProgress(String lessonId, double progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$_lessonProgressPrefix$lessonId', progress);
  }

  Future<double> getLessonProgress(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('$_lessonProgressPrefix$lessonId') ?? 0.0;
  }

  Future<void> resetCourseProgress(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_progressPrefix$courseId');
  }

  Future<void> resetLessonProgress(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_lessonProgressPrefix$lessonId');
  }
}
