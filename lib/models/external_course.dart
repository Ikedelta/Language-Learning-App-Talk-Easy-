import 'package:cloud_firestore/cloud_firestore.dart';

class ExternalCourse {
  final String? id;
  final String title;
  final String description;
  final String language;
  final String platform;
  final String url;
  final String thumbnailUrl;
  final int duration; // in minutes
  final String level;
  final double rating;
  final int ratingCount;
  final String instructor;
  final DateTime createdAt;

  ExternalCourse({
    this.id,
    required this.title,
    required this.description,
    required this.language,
    required this.platform,
    required this.url,
    required this.thumbnailUrl,
    required this.duration,
    required this.level,
    required this.rating,
    required this.ratingCount,
    required this.instructor,
    required this.createdAt,
  });

  // Convert Firestore document to ExternalCourse
  factory ExternalCourse.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ExternalCourse(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      language: data['language'] ?? '',
      platform: data['platform'] ?? '',
      url: data['url'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      duration: data['duration'] ?? 0,
      level: data['level'] ?? 'Beginner',
      rating: (data['rating'] ?? 0.0).toDouble(),
      ratingCount: data['ratingCount'] ?? 0,
      instructor: data['instructor'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert ExternalCourse to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'language': language,
      'platform': platform,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'level': level,
      'rating': rating,
      'ratingCount': ratingCount,
      'instructor': instructor,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
