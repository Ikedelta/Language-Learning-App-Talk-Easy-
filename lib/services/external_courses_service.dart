import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_talk/models/external_course.dart';

class ExternalCoursesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch courses from Firestore (which will be populated from external platforms)
  Future<List<ExternalCourse>> getExternalCourses(String language) async {
    try {
      final snapshot = await _firestore
          .collection('external_courses')
          .where('language', isEqualTo: language)
          .get();

      return snapshot.docs
          .map((doc) => ExternalCourse.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching external courses: $e');
      return [];
    }
  }

  // Add a new external course
  Future<void> addExternalCourse(ExternalCourse course) async {
    try {
      await _firestore.collection('external_courses').add(course.toMap());
    } catch (e) {
      print('Error adding external course: $e');
      rethrow;
    }
  }

  // Update an existing external course
  Future<void> updateExternalCourse(String id, ExternalCourse course) async {
    try {
      await _firestore
          .collection('external_courses')
          .doc(id)
          .update(course.toMap());
    } catch (e) {
      print('Error updating external course: $e');
      rethrow;
    }
  }

  // Delete an external course
  Future<void> deleteExternalCourse(String id) async {
    try {
      await _firestore.collection('external_courses').doc(id).delete();
    } catch (e) {
      print('Error deleting external course: $e');
      rethrow;
    }
  }
}
