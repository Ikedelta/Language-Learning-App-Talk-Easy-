// Common types used across different model files
library model_types;

export 'course_level.dart';

class VocabItem {
  final String word;
  final String translation;
  final String pronunciation;

  VocabItem({
    required this.word,
    required this.translation,
    required this.pronunciation,
  });

  Map<String, dynamic> toJson() => {
    'word': word,
    'translation': translation,
    'pronunciation': pronunciation,
  };

  factory VocabItem.fromJson(Map<String, dynamic> json) => VocabItem(
    word: json['word'] as String,
    translation: json['translation'] as String,
    pronunciation: json['pronunciation'] as String,
  );
}

class Exercise {
  final String id;
  final String type;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final String answer;

  Exercise({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.answer,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'multiple_choice',
      question: json['question'] as String,
      options: List<String>.from(json['options'] ?? []),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String? ?? '',
      answer: json['answer'] as String? ?? json['correctAnswer'] as String,
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
      'answer': answer,
    };
  }
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final List<VocabItem> vocabulary;
  final String dialogue;
  final List<String> grammarPoints;
  final List<Exercise> exercises;
  final String notes;
  final int duration;
  final String difficulty;
  final String audioUrl;
  final String videoUrl;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.vocabulary,
    this.dialogue = '',
    this.grammarPoints = const [],
    this.exercises = const [],
    this.notes = '',
    this.duration = 30,
    this.difficulty = 'beginner',
    this.audioUrl = '',
    this.videoUrl = '',
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      vocabulary: (json['vocabulary'] as List?)?.map((v) {
        if (v is String) {
          return VocabItem(
            word: v,
            translation: '', // Default empty translation
            pronunciation: '', // Default empty pronunciation
          );
        }
        return VocabItem.fromJson(v as Map<String, dynamic>);
      }).toList() ?? [],
      dialogue: json['dialogue'] as String? ?? '',
      grammarPoints: List<String>.from(json['grammarPoints'] ?? []),
      exercises: (json['exercises'] as List?)?.map((e) => Exercise.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      notes: json['notes'] as String? ?? '',
      duration: json['duration'] as int? ?? 30,
      difficulty: json['difficulty'] as String? ?? 'beginner',
      audioUrl: json['audioUrl'] as String? ?? '',
      videoUrl: json['videoUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'vocabulary': vocabulary.map((v) => v.toJson()).toList(),
      'dialogue': dialogue,
      'grammarPoints': grammarPoints,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'notes': notes,
      'duration': duration,
      'difficulty': difficulty,
      'audioUrl': audioUrl,
      'videoUrl': videoUrl,
    };
  }
}

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
    name: json['name'] as String? ?? json['title'] as String,
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

enum CourseDifficulty { beginner, intermediate, advanced }

class CourseLevel {
  final String id;
  final String name;
  final String description;
  final int level;
  final String language;
  final String imageUrl;
  final bool isLocked;
  final int requiredXp;
  final List<Lesson> lessons;

  CourseLevel({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.language,
    required this.imageUrl,
    required this.isLocked,
    required this.requiredXp,
    required this.lessons,
  });

  factory CourseLevel.fromJson(Map<String, dynamic> json) {
    return CourseLevel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      level: json['level'] as int,
      language: json['language'] as String,
      imageUrl: json['imageUrl'] as String,
      isLocked: json['isLocked'] as bool? ?? false,
      requiredXp: json['requiredXp'] as int? ?? 0,
      lessons: (json['lessons'] as List?)?.map((e) => Lesson.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'level': level,
      'language': language,
      'imageUrl': imageUrl,
      'isLocked': isLocked,
      'requiredXp': requiredXp,
      'lessons': lessons.map((e) => e.toJson()).toList(),
    };
  }
}

// CourseLevel and CourseDifficulty are now defined in course_level.dart 