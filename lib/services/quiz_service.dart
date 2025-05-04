import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz.dart';
import '../models/language_course.dart';
import '../data/english_courses.dart';
import '../data/spanish_courses.dart';

class QuizService {
  static const String _quizResultsPrefix = 'quiz_results_';
  late SharedPreferences _prefs;

  QuizService();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveQuizResult(QuizResult result) async {
    final key = '$_quizResultsPrefix${result.quizId}_${result.userId}';
    await _prefs.setString(key, result.toJson().toString());
  }

  Future<QuizResult?> getQuizResult(String quizId, String userId) async {
    final key = '$_quizResultsPrefix${quizId}_${userId}';
    final resultJson = _prefs.getString(key);
    if (resultJson != null) {
      return QuizResult.fromJson(resultJson as Map<String, dynamic>);
    }
    return null;
  }

  Quiz? getQuizForLesson(String lessonId) {
    // Search in English courses
    for (var course in englishCourses) {
      for (var lesson in course.lessons) {
        if (lesson.id == lessonId) {
          return _createQuizForLesson(lesson);
        }
      }
    }

    // Search in Spanish courses
    for (var course in spanishCourses) {
      for (var lesson in course.lessons) {
        if (lesson.id == lessonId) {
          return _createQuizForLesson(lesson);
        }
      }
    }

    return null;
  }

  Quiz _createQuizForLesson(CourseLesson lesson) {
    final questions = <QuizQuestion>[];

    // Create vocabulary questions
    for (var i = 0; i < lesson.vocabulary.length; i++) {
      if (i % 3 == 0) {
        // Create a question for every third vocabulary word
        final word = lesson.vocabulary[i];
        questions.add(QuizQuestion(
          id: '${lesson.id}_vocab_$i',
          question: 'What does "$word" mean?',
          options: _generateOptions(lesson.vocabulary, i),
          correctAnswerIndex: 0,
          explanation: 'This word is part of the lesson vocabulary.',
        ));
      }
    }

    // Create grammar questions
    for (var i = 0; i < lesson.grammarPoints.length; i++) {
      questions.add(QuizQuestion(
        id: '${lesson.id}_grammar_$i',
        question:
            'Which of the following is correct about ${lesson.grammarPoints[i]}?',
        options: _generateGrammarOptions(lesson.grammarPoints[i]),
        correctAnswerIndex: 0,
        explanation: 'This is explained in the grammar points section.',
      ));
    }

    return Quiz(
      id: '${lesson.id}_quiz',
      lessonId: lesson.id,
      questions: questions,
    );
  }

  List<String> _generateOptions(List<String> vocabulary, int correctIndex) {
    final options = <String>[];
    options.add('Correct meaning of ${vocabulary[correctIndex]}');

    // Add 3 random incorrect options
    final randomIndices = <int>[];
    while (randomIndices.length < 3) {
      final randomIndex =
          (DateTime.now().millisecondsSinceEpoch + randomIndices.length) %
              vocabulary.length;
      if (randomIndex != correctIndex && !randomIndices.contains(randomIndex)) {
        randomIndices.add(randomIndex);
        options.add('Incorrect meaning of ${vocabulary[randomIndex]}');
      }
    }

    return options..shuffle();
  }

  List<String> _generateGrammarOptions(String grammarPoint) {
    return [
      'Correct explanation of $grammarPoint',
      'Incorrect explanation 1',
      'Incorrect explanation 2',
      'Incorrect explanation 3',
    ]..shuffle();
  }
}
