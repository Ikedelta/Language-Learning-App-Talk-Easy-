class Quiz {
  final String id;
  final String lessonId;
  final List<QuizQuestion> questions;
  final int passingScore;
  final int timeLimit; // in minutes

  Quiz({
    required this.id,
    required this.lessonId,
    required this.questions,
    this.passingScore = 70,
    this.timeLimit = 10,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'lessonId': lessonId,
        'questions': questions.map((q) => q.toJson()).toList(),
        'passingScore': passingScore,
        'timeLimit': timeLimit,
      };

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json['id'],
        lessonId: json['lessonId'],
        questions: (json['questions'] as List)
            .map((q) => QuizQuestion.fromJson(q))
            .toList(),
        passingScore: json['passingScore'],
        timeLimit: json['timeLimit'],
      );
}

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'options': options,
        'correctAnswerIndex': correctAnswerIndex,
        'explanation': explanation,
      };

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        id: json['id'],
        question: json['question'],
        options: List<String>.from(json['options']),
        correctAnswerIndex: json['correctAnswerIndex'],
        explanation: json['explanation'],
      );
}

class QuizResult {
  final String quizId;
  final String userId;
  final int score;
  final int totalQuestions;
  final DateTime completedAt;
  final List<QuestionResult> questionResults;

  QuizResult({
    required this.quizId,
    required this.userId,
    required this.score,
    required this.totalQuestions,
    required this.completedAt,
    required this.questionResults,
  });

  bool get isPassed => (score / totalQuestions * 100) >= 70;

  Map<String, dynamic> toJson() => {
        'quizId': quizId,
        'userId': userId,
        'score': score,
        'totalQuestions': totalQuestions,
        'completedAt': completedAt.toIso8601String(),
        'questionResults': questionResults.map((r) => r.toJson()).toList(),
      };

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
        quizId: json['quizId'],
        userId: json['userId'],
        score: json['score'],
        totalQuestions: json['totalQuestions'],
        completedAt: DateTime.parse(json['completedAt']),
        questionResults: (json['questionResults'] as List)
            .map((r) => QuestionResult.fromJson(r))
            .toList(),
      );
}

class QuestionResult {
  final String questionId;
  final int selectedAnswerIndex;
  final bool isCorrect;
  final String explanation;

  QuestionResult({
    required this.questionId,
    required this.selectedAnswerIndex,
    required this.isCorrect,
    required this.explanation,
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'selectedAnswerIndex': selectedAnswerIndex,
        'isCorrect': isCorrect,
        'explanation': explanation,
      };

  factory QuestionResult.fromJson(Map<String, dynamic> json) => QuestionResult(
        questionId: json['questionId'],
        selectedAnswerIndex: json['selectedAnswerIndex'],
        isCorrect: json['isCorrect'],
        explanation: json['explanation'],
      );
}
