class Quiz {
  final String id;
  final String language;
  final String level;
  final List<QuizQuestion> questions;
  final int timeLimit; // in minutes
  final int passingScore;

  Quiz({
    required this.id,
    required this.language,
    required this.level,
    required this.questions,
    required this.timeLimit,
    required this.passingScore,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      language: json['language'] as String,
      level: json['level'] as String,
      questions: (json['questions'] as List)
          .map((q) => QuizQuestion.fromJson(q as Map<String, dynamic>))
          .toList(),
      timeLimit: json['timeLimit'] as int,
      passingScore: json['passingScore'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'language': language,
      'level': level,
      'questions': questions.map((q) => q.toJson()).toList(),
      'timeLimit': timeLimit,
      'passingScore': passingScore,
    };
  }
}

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final String type; // 'vocabulary', 'grammar', 'listening', etc.

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    required this.type,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctOptionIndex: json['correctOptionIndex'] as int,
      explanation: json['explanation'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'explanation': explanation,
      'type': type,
    };
  }
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

class QuizAttempt {
  final String quizId;
  final String userId;
  final DateTime startTime;
  final DateTime? endTime;
  final List<int> selectedAnswers;
  final int score;
  final bool passed;

  QuizAttempt({
    required this.quizId,
    required this.userId,
    required this.startTime,
    this.endTime,
    required this.selectedAnswers,
    required this.score,
    required this.passed,
  });
}
