import 'package:flutter/material.dart';
import 'package:easy_talk/screens/chat/ai_chat_screen.dart';
import 'package:easy_talk/screens/profile/profile_screen.dart';
import 'package:easy_talk/screens/settings/settings_screen.dart';
import 'package:easy_talk/screens/language_courses/language_courses_screen.dart';
import 'package:easy_talk/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  final Function() toggleTheme;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  final List<Language> _languages = [
    Language(
      name: 'English',
      flag: '🇺🇸',
      level: 'Beginner to Advanced',
      lessons: 50,
    ),
    Language(
      name: 'Spanish',
      flag: '🇪🇸',
      level: 'Beginner to Advanced',
      lessons: 45,
    ),
    Language(
      name: 'French',
      flag: '🇫🇷',
      level: 'Beginner to Advanced',
      lessons: 48,
    ),
    Language(
      name: 'German',
      flag: '🇩🇪',
      level: 'Beginner to Advanced',
      lessons: 42,
    ),
    Language(
      name: 'Italian',
      flag: '🇮🇹',
      level: 'Beginner to Advanced',
      lessons: 40,
    ),
    Language(
      name: 'Japanese',
      flag: '🇯🇵',
      level: 'Beginner to Advanced',
      lessons: 55,
    ),
    Language(
      name: 'Chinese',
      flag: '🇨🇳',
      level: 'Beginner to Advanced',
      lessons: 60,
    ),
    Language(
      name: 'Korean',
      flag: '🇰🇷',
      level: 'Beginner to Advanced',
      lessons: 45,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final firstName = _userData?['fullName']?.split(' ').first ?? 'User';

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHomeContent(firstName),
            const AIChatScreen(),
            const ProfileScreen(),
            SettingsScreen(toggleTheme: widget.toggleTheme),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
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

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: const Text('EasyTalk'),
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
              onPressed: widget.toggleTheme,
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
                  'Welcome back, $firstName!',
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
                Text(
                  'Available Languages',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
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
    );
  }
}

class Language {
  final String name;
  final String flag;
  final String level;
  final int lessons;

  Language({
    required this.name,
    required this.flag,
    required this.level,
    required this.lessons,
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
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          if (language.name == 'English' || language.name == 'Spanish') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    LanguageCoursesScreen(language: language.name),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${language.name} courses coming soon!'),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
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
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                language.level,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.book_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${language.lessons} Lessons',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
