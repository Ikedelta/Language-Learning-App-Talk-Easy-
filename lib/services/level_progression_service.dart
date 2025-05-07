import 'package:shared_preferences/shared_preferences.dart';
import '../models/language_course.dart';

class LevelProgressionService {
  static const String _completedCoursesPrefix = 'completed_courses_';
  static const String _courseScoresPrefix = 'course_scores_';

  // Check if a course is unlocked based on prerequisites and scores
  Future<bool> isCourseUnlocked(LanguageCourse course) async {
    final prefs = await SharedPreferences.getInstance();

    // Get completed courses for the language
    final completedCourses =
        prefs.getStringList('${_completedCoursesPrefix}${course.language}') ??
            [];

    // Check prerequisites
    for (final prerequisite in course.prerequisites) {
      if (!completedCourses.contains(prerequisite)) {
        return false;
      }
    }

    // Check required score
    if (course.requiredScore > 0) {
      final totalScore = await _getTotalScore(course.language);
      if (totalScore < course.requiredScore) {
        return false;
      }
    }

    return true;
  }

  // Mark a course as completed
  Future<void> completeCourse(String courseId, String language) async {
    final prefs = await SharedPreferences.getInstance();
    final completedCourses =
        prefs.getStringList('${_completedCoursesPrefix}$language') ?? [];

    if (!completedCourses.contains(courseId)) {
      completedCourses.add(courseId);
      await prefs.setStringList(
          '${_completedCoursesPrefix}$language', completedCourses);
    }
  }

  // Update course score
  Future<void> updateCourseScore(String courseId, int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${_courseScoresPrefix}$courseId', score);
  }

  // Get total score for a language
  Future<int> _getTotalScore(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final completedCourses =
        prefs.getStringList('${_completedCoursesPrefix}$language') ?? [];

    int totalScore = 0;
    for (final courseId in completedCourses) {
      totalScore += prefs.getInt('${_courseScoresPrefix}$courseId') ?? 0;
    }

    return totalScore;
  }

  // Get next available course
  Future<LanguageCourse?> getNextAvailableCourse(
      List<LanguageCourse> courses) async {
    for (final course in courses) {
      if (await isCourseUnlocked(course)) {
        return course;
      }
    }
    return null;
  }

  // Get course progress percentage
  Future<double> getCourseProgress(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('course_progress_$courseId') ?? 0.0;
  }
}
