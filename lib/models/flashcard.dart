import 'dart:convert';

class Flashcard {
  final String word;
  final String translation;
  final String pronunciation;

  Flashcard({
    required this.word,
    required this.translation,
    required this.pronunciation,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      word: json['word'] as String,
      translation: json['translation'] as String,
      pronunciation: json['pronunciation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'translation': translation,
      'pronunciation': pronunciation,
    };
  }

  @override
  String toString() {
    return 'Flashcard{word: $word, translation: $translation, pronunciation: $pronunciation}';
  }
} 