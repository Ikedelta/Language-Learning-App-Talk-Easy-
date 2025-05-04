import 'package:flutter/material.dart';
import '../../models/quiz.dart';
import '../../services/quiz_service.dart';

class QuizScreen extends StatefulWidget {
  final String lessonId;
  final String userId;

  const QuizScreen({
    Key? key,
    required this.lessonId,
    required this.userId,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Quiz _quiz;
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  int _score = 0;
  bool _isQuizCompleted = false;
  late QuizService _quizService;
  List<QuestionResult> _questionResults = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _quizService = QuizService();
    _initializeQuiz();
  }

  Future<void> _initializeQuiz() async {
    await _quizService.init();
    final quiz = _quizService.getQuizForLesson(widget.lessonId);
    if (quiz != null) {
      setState(() {
        _quiz = quiz;
        _isLoading = false;
      });
    }
  }

  void _submitAnswer() {
    if (_selectedAnswerIndex == null) return;

    final isCorrect = _selectedAnswerIndex ==
        _quiz.questions[_currentQuestionIndex].correctAnswerIndex;
    if (isCorrect) {
      setState(() {
        _score++;
      });
    }

    _questionResults.add(QuestionResult(
      questionId: _quiz.questions[_currentQuestionIndex].id,
      selectedAnswerIndex: _selectedAnswerIndex!,
      isCorrect: isCorrect,
      explanation: _quiz.questions[_currentQuestionIndex].explanation,
    ));

    if (_currentQuestionIndex < _quiz.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
      });
    } else {
      _completeQuiz();
    }
  }

  Future<void> _completeQuiz() async {
    final result = QuizResult(
      quizId: _quiz.id,
      userId: widget.userId,
      score: _score,
      totalQuestions: _quiz.questions.length,
      completedAt: DateTime.now(),
      questionResults: _questionResults,
    );

    await _quizService.saveQuizResult(result);
    setState(() {
      _isQuizCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isQuizCompleted) {
      return _buildResultsScreen();
    }

    if (_quiz.questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No questions available for this quiz.'),
        ),
      );
    }

    final currentQuestion = _quiz.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Quiz - Question ${_currentQuestionIndex + 1}/${_quiz.questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _quiz.questions.length,
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion.question,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ...currentQuestion.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: _selectedAnswerIndex == null
                      ? () => setState(() => _selectedAnswerIndex = index)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedAnswerIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedAnswerIndex == null ? null : _submitAnswer,
              child: const Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final percentage = (_score / _quiz.questions.length * 100).round();
    final isPassed = percentage >= _quiz.passingScore;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPassed ? Icons.check_circle : Icons.cancel,
              color: isPassed ? Colors.green : Colors.red,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score: $percentage%',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            Text(
              'You got $_score out of ${_quiz.questions.length} questions correct.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}
