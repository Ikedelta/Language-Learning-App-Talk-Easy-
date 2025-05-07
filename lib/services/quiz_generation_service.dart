import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import '../models/quiz.dart';
import '../models/language_course.dart';
import 'package:uuid/uuid.dart';

class QuizGenerationService {
  final GenerativeModel _model;
  static const String _apiKey =
      'YOUR_GEMINI_API_KEY'; // Replace with your API key

  QuizGenerationService()
      : _model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: _apiKey,
        );

  Future<Quiz> generateQuizForLesson(
      CourseLesson lesson, String language, String level) async {
    final prompt = '''
Generate a quiz for a $language language lesson at $level level.
Lesson title: ${lesson.title}
Lesson description: ${lesson.description}
Vocabulary: ${lesson.vocabulary.join(', ')}
Grammar points: ${lesson.grammarPoints.join(', ')}

Generate 5 questions that test understanding of the lesson content.
Include a mix of multiple choice, fill in the blank, and translation questions.
Format the response as JSON with the following structure:
{
  "questions": [
    {
      "id": "unique_id",
      "question": "question text",
      "options": ["option1", "option2", "option3", "option4"],
      "correctOptionIndex": 0,
      "explanation": "explanation of the correct answer",
      "questionType": "multiple_choice|fill_blank|translation"
    }
  ]
}
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      final jsonResponse = response.text ?? '';

      // Parse the JSON response and create a Quiz object
      final Map<String, dynamic> quizData = json.decode(jsonResponse);

      return Quiz(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        language: language,
        level: level,
        questions: (quizData['questions'] as List)
            .map((q) => QuizQuestion(
                  id: q['id'] ?? const Uuid().v4(),
                  question: q['question'],
                  options: List<String>.from(q['options']),
                  correctOptionIndex: q['correctOptionIndex'],
                  explanation: q['explanation'],
                  type: q['questionType'],
                ))
            .toList(),
        timeLimit: 10, // 10 minutes
        passingScore: 70, // 70% passing score
      );
    } catch (e) {
      print('Error generating quiz: $e');
      rethrow;
    }
  }

  Future<List<Quiz>> generateQuizzesForCourse(LanguageCourse course) async {
    List<Quiz> quizzes = [];

    for (final lesson in course.lessons) {
      try {
        final quiz = await generateQuizForLesson(
          lesson,
          course.language,
          course.level,
        );
        quizzes.add(quiz);
      } catch (e) {
        print('Error generating quiz for lesson ${lesson.id}: $e');
      }
    }

    return quizzes;
  }
}
