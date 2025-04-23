class LanguageCourse {
  final String id;
  final String title;
  final String description;
  final String level;
  final List<CourseLesson> lessons;
  final String imageUrl;
  final String language;

  LanguageCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.lessons,
    required this.imageUrl,
    required this.language,
  });
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
} 