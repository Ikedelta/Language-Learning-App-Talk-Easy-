import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/language_course.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<LanguageCourse>> getCoursesByLanguage(String language) {
    return _firestore
        .collection('courses')
        .where('language', isEqualTo: language)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return LanguageCourse(
          id: doc.id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          level: data['level'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          language: data['language'] ?? '',
          lessons: (data['lessons'] as List?)?.map((lesson) {
                return CourseLesson(
                  id: lesson['id'] ?? '',
                  title: lesson['title'] ?? '',
                  description: lesson['description'] ?? '',
                  vocabulary: List<String>.from(lesson['vocabulary'] ?? []),
                  grammarPoints:
                      List<String>.from(lesson['grammarPoints'] ?? []),
                  exercises: List<String>.from(lesson['exercises'] ?? []),
                  audioUrl: lesson['audioUrl'] ?? '',
                  videoUrl: lesson['videoUrl'] ?? '',
                  notes: lesson['notes'] ?? '',
                );
              }).toList() ??
              [],
        );
      }).toList();
    });
  }

  Stream<List<LanguageCourse>> getAllCourses() {
    return _firestore.collection('courses').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return LanguageCourse(
          id: doc.id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          level: data['level'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          language: data['language'] ?? '',
          lessons: (data['lessons'] as List?)?.map((lesson) {
                return CourseLesson(
                  id: lesson['id'] ?? '',
                  title: lesson['title'] ?? '',
                  description: lesson['description'] ?? '',
                  vocabulary: List<String>.from(lesson['vocabulary'] ?? []),
                  grammarPoints:
                      List<String>.from(lesson['grammarPoints'] ?? []),
                  exercises: List<String>.from(lesson['exercises'] ?? []),
                  audioUrl: lesson['audioUrl'] ?? '',
                  videoUrl: lesson['videoUrl'] ?? '',
                  notes: lesson['notes'] ?? '',
                );
              }).toList() ??
              [],
        );
      }).toList();
    });
  }
}
