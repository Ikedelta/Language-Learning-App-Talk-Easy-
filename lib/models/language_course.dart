class LanguageCourse {
  final String id;
  final String title;
  final String description;
  final String level;
  final List<CourseLesson> lessons;
  final String imageUrl;
  final String language;
  final List<String> prerequisites; // IDs of courses that must be completed
  final int requiredScore; // Minimum score required to unlock this level

  LanguageCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.lessons,
    required this.imageUrl,
    required this.language,
    this.prerequisites = const [],
    this.requiredScore = 0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'level': level,
    'imageUrl': imageUrl,
    'language': language,
    'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
  };

  factory LanguageCourse.fromJson(Map<String, dynamic> json) => LanguageCourse(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    level: json['level'] as String,
    imageUrl: json['imageUrl'] as String,
    language: json['language'] as String,
    lessons: (json['lessons'] as List?)
        ?.map((lesson) => CourseLesson.fromJson(lesson as Map<String, dynamic>))
        .toList() ?? [],
  );
}

class CourseLesson {
  final String id;
  final String title;
  final String description;
  final List<String> vocabulary;
  final List<String> grammarPoints;
  final List<String> exercises;
  final String audioUrl;
  final String videoUrl;
  final String notes;

  CourseLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.vocabulary,
    required this.grammarPoints,
    required this.exercises,
    required this.audioUrl,
    required this.videoUrl,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'vocabulary': vocabulary,
    'grammarPoints': grammarPoints,
    'exercises': exercises,
    'audioUrl': audioUrl,
    'videoUrl': videoUrl,
    'notes': notes,
  };

  factory CourseLesson.fromJson(Map<String, dynamic> json) => CourseLesson(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    vocabulary: List<String>.from(json['vocabulary'] ?? []),
    grammarPoints: List<String>.from(json['grammarPoints'] ?? []),
    exercises: List<String>.from(json['exercises'] ?? []),
    audioUrl: json['audioUrl'] as String? ?? '',
    videoUrl: json['videoUrl'] as String? ?? '',
    notes: json['notes'] as String? ?? '',
  );
}
