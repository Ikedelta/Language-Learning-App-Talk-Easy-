class GrammarLesson {
  final String id;
  final String title;
  final String description;
  final String level;
  final String language;
  final List<String> examples;
  final List<String> rules;
  final List<String> practiceExercises;
  final int order;

  GrammarLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.language,
    required this.examples,
    required this.rules,
    required this.practiceExercises,
    required this.order,
  });

  factory GrammarLesson.fromJson(Map<String, dynamic> json) {
    return GrammarLesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      level: json['level'] as String,
      language: json['language'] as String,
      examples: List<String>.from(json['examples']),
      rules: List<String>.from(json['rules']),
      practiceExercises: List<String>.from(json['practiceExercises']),
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'level': level,
      'language': language,
      'examples': examples,
      'rules': rules,
      'practiceExercises': practiceExercises,
      'order': order,
    };
  }
}
