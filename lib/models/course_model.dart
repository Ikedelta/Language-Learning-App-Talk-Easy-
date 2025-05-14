import 'course_level.dart';
import 'model_types.dart';

// Re-export needed types from model_types.dart
export 'model_types.dart' show Course, Lesson, Exercise, VocabItem;

class Course {
  final String id;
  final String name;
  final String title;
  final String description;
  final String language;
  final String level;
  final DateTime createdAt;
  final String userId;
  final List<Lesson> lessons;

  Course({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.language,
    required this.level,
    required this.createdAt,
    required this.userId,
    required this.lessons,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'title': title,
    'description': description,
    'language': language,
    'level': level,
    'createdAt': createdAt.toIso8601String(),
    'userId': userId,
    'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
  };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json['id'] as String,
    name: json['name'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    language: json['language'] as String,
    level: json['level'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    userId: json['userId'] as String,
    lessons: (json['lessons'] as List)
        .map((lesson) => Lesson.fromJson(lesson as Map<String, dynamic>))
        .toList(),
  );
}

// Additional course-related types and utilities can go here



 