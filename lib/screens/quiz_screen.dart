import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../services/quiz_service.dart';
import '../utils/app_theme.dart';

class QuizScreen extends StatefulWidget {
  final String language;
  final String level;
  final int questionCount;

  const QuizScreen({
    super.key,
    required this.language,
    required this.level,
    required this.questionCount,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quizService = QuizService();
  late Future<Quiz> _quizFuture;
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  int _score = 0;
  bool _showExplanation = false;
  List<int> _userAnswers = [];
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _quizFuture = _quizService.generateQuiz(
      language: widget.language,
      level: widget.level,
      questionCount: widget.questionCount,
      type: 'mixed',
    );
  }

  void _handleAnswer(int optionIndex) {
    if (_showExplanation) return;

    setState(() {
      _selectedOptionIndex = optionIndex;
      _showExplanation = true;
      _userAnswers.add(optionIndex);

      final currentQuestion = (_quizFuture as Future<Quiz>)
          .then((quiz) => quiz.questions[_currentQuestionIndex]);
      currentQuestion.then((question) {
        if (optionIndex == question.correctOptionIndex) {
          _score++;
        }
      });
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questionCount - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _showExplanation = false;
      });
    } else {
      _finishQuiz();
    }
  }

  Future<void> _finishQuiz() async {
    final quiz = await _quizFuture;
    final timeTaken = DateTime.now().difference(_startTime!).inSeconds;

    await _quizService.submitQuizResult(
      quizId: quiz.id,
      userId: 'current_user_id', // TODO: Get from auth service
      score: (_score / widget.questionCount * 100).round(),
      userAnswers: _userAnswers,
      timeTaken: timeTaken,
    );

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          score: _score,
          totalQuestions: widget.questionCount,
          timeTaken: timeTaken,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FutureBuilder<Quiz>(
                future: _quizFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  return Text(
                    '${_currentQuestionIndex + 1}/${widget.questionCount}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Quiz>(
        future: _quizFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final quiz = snapshot.data!;
          final question = quiz.questions[_currentQuestionIndex];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${_currentQuestionIndex + 1}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question.question,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ...List.generate(
                  question.options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildOptionButton(
                      question,
                      index,
                    ),
                  ),
                ),
                if (_showExplanation) ...[
                  const SizedBox(height: 24),
                  Card(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Explanation',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(question.explanation),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _currentQuestionIndex < widget.questionCount - 1
                          ? 'Next Question'
                          : 'Finish Quiz',
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOptionButton(QuizQuestion question, int index) {
    final isSelected = _selectedOptionIndex == index;
    final isCorrect = index == question.correctOptionIndex;
    Color? backgroundColor;
    Color? textColor;

    if (_showExplanation) {
      if (isCorrect) {
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
      } else if (isSelected) {
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
      }
    } else if (isSelected) {
      backgroundColor = AppTheme.primaryColor.withOpacity(0.1);
      textColor = AppTheme.primaryColor;
    }

    return ElevatedButton(
      onPressed: () => _handleAnswer(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
          ),
        ),
      ),
      child: Text(question.options[index]),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int timeTaken;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.timeTaken,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions * 100).round();
    final minutes = (timeTaken / 60).floor();
    final seconds = timeTaken % 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You got $score out of $totalQuestions questions correct',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Time taken: ${minutes}m ${seconds}s',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
