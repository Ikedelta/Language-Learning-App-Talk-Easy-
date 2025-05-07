import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/quiz.dart';

class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _quizzesCollection;
  final CollectionReference _quizResultsCollection;

  QuizService()
      : _quizzesCollection = FirebaseFirestore.instance.collection('quizzes'),
        _quizResultsCollection =
            FirebaseFirestore.instance.collection('quiz_results');

  Future<void> init() async {
    // Initialize any necessary resources
  }

  // Generate a quiz for a specific language and level
  Future<Quiz> generateQuiz({
    required String language,
    required String level,
    required int questionCount,
    required String type,
  }) async {
    // Get vocabulary and grammar points for the level
    final vocabulary = await _getVocabularyForLevel(language, level);
    final grammarPoints = await _getGrammarPointsForLevel(language, level);

    // Generate questions based on vocabulary and grammar
    final questions = <QuizQuestion>[];

    // Add vocabulary questions
    final vocabQuestions = _generateVocabularyQuestions(
      vocabulary,
      questionCount ~/ 2,
      language,
    );
    questions.addAll(vocabQuestions);

    // Add grammar questions
    final grammarQuestions = _generateGrammarQuestions(
      grammarPoints,
      questionCount - vocabQuestions.length,
      language,
    );
    questions.addAll(grammarQuestions);

    // Create and save the quiz
    final quiz = Quiz(
      id: const Uuid().v4(),
      language: language,
      level: level,
      questions: questions,
      timeLimit: 10, // 10 minutes
      passingScore: 70, // 70% passing score
    );

    await _quizzesCollection.doc(quiz.id).set(quiz.toJson());
    return quiz;
  }

  // Get vocabulary for a specific level
  Future<List<Map<String, dynamic>>> _getVocabularyForLevel(
    String language,
    String level,
  ) async {
    final snapshot = await _firestore
        .collection('vocabulary')
        .where('language', isEqualTo: language)
        .where('level', isEqualTo: level)
        .get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // Get grammar points for a specific level
  Future<List<Map<String, dynamic>>> _getGrammarPointsForLevel(
    String language,
    String level,
  ) async {
    final snapshot = await _firestore
        .collection('grammar')
        .where('language', isEqualTo: language)
        .where('level', isEqualTo: level)
        .get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // Generate vocabulary questions
  List<QuizQuestion> _generateVocabularyQuestions(
    List<Map<String, dynamic>> vocabulary,
    int count,
    String language,
  ) {
    final questions = <QuizQuestion>[];
    final random = vocabulary.toList()..shuffle();

    for (var i = 0; i < count && i < random.length; i++) {
      final word = random[i];
      final options = _generateVocabularyOptions(word, random, language);

      questions.add(QuizQuestion(
        id: const Uuid().v4(),
        question: 'What is the meaning of "${word['word']}"?',
        options: options,
        correctOptionIndex: 0,
        explanation: '${word['word']} means ${word['translation']}',
        type: 'vocabulary',
      ));
    }

    return questions;
  }

  // Generate grammar questions
  List<QuizQuestion> _generateGrammarQuestions(
    List<Map<String, dynamic>> grammarPoints,
    int count,
    String language,
  ) {
    final questions = <QuizQuestion>[];
    final random = grammarPoints.toList()..shuffle();

    for (var i = 0; i < count && i < random.length; i++) {
      final point = random[i];
      final options = _generateGrammarOptions(point, random, language);

      questions.add(QuizQuestion(
        id: const Uuid().v4(),
        question: point['question'],
        options: options,
        correctOptionIndex: 0,
        explanation: point['explanation'],
        type: 'grammar',
      ));
    }

    return questions;
  }

  // Generate options for vocabulary questions
  List<String> _generateVocabularyOptions(
    Map<String, dynamic> correctWord,
    List<Map<String, dynamic>> allWords,
    String language,
  ) {
    final options = <String>[correctWord['translation']];
    final random = allWords.toList()
      ..remove(correctWord)
      ..shuffle();

    for (var i = 0; i < 3 && i < random.length; i++) {
      options.add(random[i]['translation']);
    }

    options.shuffle();
    return options;
  }

  // Generate options for grammar questions
  List<String> _generateGrammarOptions(
    Map<String, dynamic> correctPoint,
    List<Map<String, dynamic>> allPoints,
    String language,
  ) {
    final options = <String>[correctPoint['answer']];
    final random = allPoints.toList()
      ..remove(correctPoint)
      ..shuffle();

    for (var i = 0; i < 3 && i < random.length; i++) {
      options.add(random[i]['answer']);
    }

    options.shuffle();
    return options;
  }

  // Get a quiz by ID
  Future<Quiz?> getQuiz(String quizId) async {
    final doc = await _quizzesCollection.doc(quizId).get();
    if (!doc.exists) return null;
    return Quiz.fromJson(doc.data() as Map<String, dynamic>);
  }

  // Submit quiz results
  Future<void> submitQuizResult({
    required String quizId,
    required String userId,
    required int score,
    required List<int> userAnswers,
    required int timeTaken,
  }) async {
    await _quizResultsCollection.add({
      'quizId': quizId,
      'userId': userId,
      'score': score,
      'userAnswers': userAnswers,
      'timeTaken': timeTaken,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get user's quiz history
  Future<List<QuizResult>> getUserQuizHistory(String userId) async {
    try {
      final snapshot = await _quizResultsCollection
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => QuizResult.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting user quiz history: $e');
      rethrow;
    }
  }

  // Get quiz statistics for a user
  Future<Map<String, dynamic>> getUserQuizStats(String userId) async {
    try {
      final snapshot =
          await _quizResultsCollection.where('userId', isEqualTo: userId).get();

      if (snapshot.docs.isEmpty) {
        return {
          'totalQuizzes': 0,
          'averageScore': 0.0,
          'highestScore': 0,
          'totalQuestions': 0,
          'correctAnswers': 0,
        };
      }

      int totalQuizzes = snapshot.docs.length;
      int totalScore = 0;
      int highestScore = 0;
      int totalQuestions = 0;
      int correctAnswers = 0;

      for (var doc in snapshot.docs) {
        final result = QuizResult.fromJson(doc.data() as Map<String, dynamic>);
        totalScore += result.score;
        highestScore =
            result.score > highestScore ? result.score : highestScore;
        totalQuestions += result.totalQuestions;
        correctAnswers += result.score;
      }

      return {
        'totalQuizzes': totalQuizzes,
        'averageScore': totalScore / totalQuizzes,
        'highestScore': highestScore,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
      };
    } catch (e) {
      print('Error getting user quiz stats: $e');
      rethrow;
    }
  }

  // Get a quiz for a specific lesson
  Future<Quiz?> getQuizForLesson(String lessonId) async {
    try {
      final snapshot = await _quizzesCollection
          .where('lessonId', isEqualTo: lessonId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return Quiz.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error getting quiz for lesson: $e');
      rethrow;
    }
  }

  // Save quiz result
  Future<void> saveQuizResult(QuizResult result) async {
    try {
      await _quizResultsCollection.add(result.toJson());
    } catch (e) {
      print('Error saving quiz result: $e');
      rethrow;
    }
  }
}
