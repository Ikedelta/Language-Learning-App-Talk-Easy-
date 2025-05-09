import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/theme_service.dart';
import '../../services/auth_service.dart';
import 'package:easy_talk/screens/chat/ai_chat_screen.dart';
import 'package:easy_talk/screens/profile/profile_screen.dart';
import 'package:easy_talk/screens/settings/settings_screen.dart';
import 'package:easy_talk/screens/language_courses/language_courses_screen.dart';
import 'package:easy_talk/screens/language_courses/course_levels_screen.dart';
import 'package:easy_talk/models/course_level.dart';
import 'package:easy_talk/services/course_service.dart';
import 'package:easy_talk/services/course_content_service.dart';
import 'package:easy_talk/services/course_progress_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  final CourseService _courseService = CourseService();
  final CourseContentService _courseContentService = CourseContentService();
  final CourseProgressService _progressService = CourseProgressService();
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  List<CourseLevel> _recentCourses = [];
  List<CourseLevel> _recommendedCourses = [];
  double _overallProgress = 0.0;
  int _totalXp = 0;
  int _currentLevel = 1;

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
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadCourses();
    _loadProgress();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final user = _authService.currentUser;
    if (user != null) {
      final userData = await _authService.getUserData(user.uid);
      setState(() {
        _userData = userData.data() as Map<String, dynamic>?;
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCourses() async {
    try {
      // Initialize all courses
      await _courseContentService.initializeDefaultCourses();

      // Load courses for display
      final recent = await _courseService.getCourseLevels('english');
      final recommended = await _courseService.getCourseLevels('spanish');
      setState(() {
        _recentCourses = recent;
        _recommendedCourses = recommended;
      });
    } catch (e) {
      print('Error loading courses: $e');
      // Handle error
    }
  }

  Future<void> _loadProgress() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Load progress for each language
        final languages = [
          'english',
          'spanish',
          'french',
          'german',
          'japanese'
        ];
        double totalProgress = 0.0;
        int totalXp = 0;

        for (final language in languages) {
          final progress =
              await _courseService.getUserProgress(user.uid, language);
          totalProgress += progress['completionPercentage'] ?? 0.0;
          totalXp += ((progress['totalScore'] ?? 0) as num).toInt();
        }

        setState(() {
          _overallProgress = totalProgress / languages.length;
          _totalXp = totalXp;
          final level = (_totalXp ~/ 100) + 1;
          _currentLevel = level; // Level up every 100 XP
        });
      }
    } catch (e) {
      print('Error loading progress: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final firstName = _userData?['fullName']?.split(' ').first ?? 'User';

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHomeContent(firstName),
            const AIChatScreen(),
            const ProfileScreen(),
            const SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        elevation: 8,
        height: 65,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'AI Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(String firstName) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('EasyTalk'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // TODO: Implement search
                },
              ),
              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () =>
                    Provider.of<ThemeService>(context, listen: false)
                        .toggleTheme(),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, $firstName! 👋',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Continue your language learning journey',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildProgressCard(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Continue Learning'),
                  const SizedBox(height: 16),
                  _buildRecentCourses(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Available Languages'),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final language = _languages[index];
                  return _LanguageCard(language: language);
                },
                childCount: _languages.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Progress',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Level $_currentLevel',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: _overallProgress / 100,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_overallProgress.toStringAsFixed(1)}% Complete',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '$_totalXp XP',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        TextButton(
          onPressed: () {
            if (title == 'Continue Learning') {
              // Navigate to all enrolled courses
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageCoursesScreen(
                    language: 'english',
                    level: 'all',
                  ),
                ),
              );
            } else if (title == 'Available Languages') {
              // Navigate to all available languages
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseLevelsScreen(
                    language: 'all',
                  ),
                ),
              );
            }
          },
          child: Text(
            'View All',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCourses() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _recentCourses.length,
        itemBuilder: (context, index) {
          final course = _recentCourses[index];
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Navigate to course detail
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              course.level.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Icon(
                            Icons.lock_outline,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        course.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${course.lessons.length.toString()} Lessons',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: 0.3,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
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
                  language: language.name,
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
