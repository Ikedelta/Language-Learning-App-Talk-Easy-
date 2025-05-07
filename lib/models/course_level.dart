import 'package:flutter/material.dart';

enum CourseDifficulty { beginner, intermediate, advanced }

class CourseLevel {
  final String id;
  final String name;
  final String description;
  final int level;
  final List<Lesson> lessons;
  final String language;
  final String imageUrl;
  final bool isLocked;
  final int requiredXp;

  CourseLevel({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.lessons,
    required this.language,
    required this.imageUrl,
    this.isLocked = true,
    this.requiredXp = 0,
  });

  factory CourseLevel.fromJson(Map<String, dynamic> json) {
    return CourseLevel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      level: json['level'] as int,
      lessons: (json['lessons'] as List)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
      language: json['language'] as String,
      imageUrl: json['imageUrl'] as String,
      isLocked: json['isLocked'] as bool? ?? true,
      requiredXp: json['requiredXp'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'level': level,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
      'language': language,
      'imageUrl': imageUrl,
      'isLocked': isLocked,
      'requiredXp': requiredXp,
    };
  }
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final List<String> vocabulary;
  final List<String> grammarPoints;
  final List<Exercise> exercises;
  final int duration; // in minutes
  final String difficulty;
  final bool isCompleted;
  final int xpReward;
  final String audioUrl;
  final String videoUrl;
  final String notes;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.vocabulary,
    required this.grammarPoints,
    required this.exercises,
    required this.duration,
    required this.difficulty,
    this.isCompleted = false,
    this.xpReward = 10,
    this.audioUrl = '',
    this.videoUrl = '',
    this.notes = '',
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      vocabulary: List<String>.from(json['vocabulary']),
      grammarPoints: List<String>.from(json['grammarPoints']),
      exercises: (json['exercises'] as List)
          .map((exercise) => Exercise.fromJson(exercise))
          .toList(),
      duration: json['duration'] as int,
      difficulty: json['difficulty'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      xpReward: json['xpReward'] as int? ?? 10,
      audioUrl: json['audioUrl'] as String? ?? '',
      videoUrl: json['videoUrl'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'vocabulary': vocabulary,
      'grammarPoints': grammarPoints,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
      'duration': duration,
      'difficulty': difficulty,
      'isCompleted': isCompleted,
      'xpReward': xpReward,
      'audioUrl': audioUrl,
      'videoUrl': videoUrl,
      'notes': notes,
    };
  }
}

class Exercise {
  final String id;
  final String type; // 'multiple_choice', 'fill_blank', 'translation'
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  Exercise({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      type: json['type'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
    };
  }
}
