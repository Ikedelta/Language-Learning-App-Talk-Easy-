import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/course_level.dart';
import '../../services/course_service.dart';
import '../../services/auth_service.dart';
import 'lesson_screen.dart';
import 'language_courses_screen.dart';

class CourseLevelsScreen extends StatefulWidget {
  final String language;

  const CourseLevelsScreen({
    super.key,
    required this.language,
  });

  @override
  State<CourseLevelsScreen> createState() => _CourseLevelsScreenState();
}

class _CourseLevelsScreenState extends State<CourseLevelsScreen> {
  final CourseService _courseService = CourseService();
  final AuthService _authService = AuthService();
  List<CourseLevel> _levels = [];
  Map<String, dynamic> _userProgress = {};
  bool _isLoading = true;

  final List<Language> _languages = [
    Language(
      name: 'English',
      flag: '🇺🇸',
      level: 'Beginner to Advanced',
      lessons: 50,
      color: Colors.blue,
      gradient: [Colors.blue.shade400, Colors.blue.shade700],
    ),
    Language(
      name: 'Spanish',
      flag: '🇪🇸',
      level: 'Beginner to Advanced',
      lessons: 45,
      color: Colors.red,
      gradient: [Colors.red.shade400, Colors.red.shade700],
    ),
    Language(
      name: 'French',
      flag: '🇫🇷',
      level: 'Beginner to Advanced',
      lessons: 48,
      color: Colors.purple,
      gradient: [Colors.purple.shade400, Colors.purple.shade700],
    ),
    Language(
      name: 'German',
      flag: '🇩🇪',
      level: 'Beginner to Advanced',
      lessons: 42,
      color: Colors.amber,
      gradient: [Colors.amber.shade400, Colors.amber.shade700],
    ),
    Language(
      name: 'Italian',
      flag: '🇮🇹',
      level: 'Beginner to Advanced',
      lessons: 40,
      color: Colors.green,
      gradient: [Colors.green.shade400, Colors.green.shade700],
    ),
    Language(
      name: 'Japanese',
      flag: '🇯🇵',
      level: 'Beginner to Advanced',
      lessons: 55,
      color: Colors.pink,
      gradient: [Colors.pink.shade400, Colors.pink.shade700],
    ),
    Language(
      name: 'Chinese',
      flag: '🇨🇳',
      level: 'Beginner to Advanced',
      lessons: 60,
      color: Colors.orange,
      gradient: [Colors.orange.shade400, Colors.orange.shade700],
    ),
    Language(
      name: 'Korean',
      flag: '🇰🇷',
      level: 'Beginner to Advanced',
      lessons: 45,
      color: Colors.indigo,
      gradient: [Colors.indigo.shade400, Colors.indigo.shade700],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  Future<void> _loadLevels() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        if (widget.language == 'all') {
          setState(() {
            _isLoading = false;
          });
        } else {
          final levels = await _courseService.getCourseLevels(widget.language);
          final progress = await _courseService.getUserProgress(
            user.uid,
            widget.language,
          );
          setState(() {
            _levels = levels;
            _userProgress = progress;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading levels: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.language == 'all'
            ? 'All Languages'
            : '${widget.language} Courses'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.language == 'all'
              ? GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    return _LanguageCard(language: language);
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _levels.length,
                  itemBuilder: (context, index) {
                    final level = _levels[index];
                    return _buildLevelCard(level);
                  },
                ),
    );
  }

  Widget _buildLevelCard(CourseLevel level) {
    final isUnlocked =
        level.level == 1 || _userProgress['totalScore'] >= level.requiredXp;
    final progress = _calculateProgress(level);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: isUnlocked
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonScreen(
                      language: level.language,
                      level: level,
                    ),
                  ),
                ).then((_) => _loadLevels());
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isUnlocked
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${level.level}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          level.name,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          level.description,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  isUnlocked
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(progress * 100).toInt()}% Complete',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateProgress(CourseLevel level) {
    final completedLessons = _userProgress['completedLessons'] as List? ?? [];
    final levelLessons = level.lessons.map((l) => l.id).toList();
    final completedLevelLessons =
        completedLessons.where((id) => levelLessons.contains(id)).length;
    return levelLessons.isEmpty
        ? 0.0
        : completedLevelLessons / levelLessons.length;
  }
}

class Language {
  final String name;
  final String flag;
  final String level;
  final int lessons;
  final Color color;
  final List<Color> gradient;

  Language({
    required this.name,
    required this.flag,
    required this.level,
    required this.lessons,
    required this.color,
    required this.gradient,
  });
}

class _LanguageCard extends StatelessWidget {
  final Language language;

  const _LanguageCard({
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: language.color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          if (language.name == 'English' ||
              language.name == 'Spanish' ||
              language.name == 'French' ||
              language.name == 'German' ||
              language.name == 'Japanese') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LanguageCoursesScreen(
                  language: language.name.toLowerCase(),
                  level: 'beginner',
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${language.name} courses coming soon!'),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: language.gradient,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language.flag,
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 16),
                Text(
                  language.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  language.level,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${language.lessons} Lessons',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
