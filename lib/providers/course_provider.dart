import 'package:flutter/foundation.dart';
import 'package:easy_talk/models/course_model.dart';
import 'package:easy_talk/services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  final CourseService _courseService;
  List<Course> _courses = [];
  Course? _currentCourse;
  bool _isLoading = false;
  String? _error;

  CourseProvider({CourseService? courseService})
      : _courseService = courseService ?? CourseService();

  List<Course> get courses => _courses;
  Course? get currentCourse => _currentCourse;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> generateCourse({
    required String language,
    required String level,
    required String userId,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _currentCourse = await _courseService.generateCourse(
        language: language,
        level: level,
        userId: userId,
      );

      _courses = [_currentCourse!, ..._courses];
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCoursesByLanguage(String language) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      print('CourseProvider: Starting to load courses for language: $language');
      final fetchedCourses = await _courseService.fetchCoursesByLanguage(language);
      print('CourseProvider: Fetched ${fetchedCourses.length} courses');
      
      _courses = fetchedCourses;
      print('CourseProvider: Updated courses list. New length: ${_courses.length}');
      
      if (_courses.isNotEmpty) {
        print('CourseProvider: First course title: ${_courses.first.title}');
      }
      
      notifyListeners();
    } catch (e) {
      print('CourseProvider: Error loading courses: $e');
      _error = e.toString();
      _courses = [];
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCoursesByLevel(String level) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _courses = await _courseService.getCoursesByLevel(level);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCourseById(String courseId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _currentCourse = await _courseService.getCourseById(courseId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCurrentCourse() {
    _currentCourse = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 