import 'package:flutter/material.dart';
import '../utils/app_icons.dart';
import '../utils/app_theme.dart';
import 'quiz_screen.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPracticeModes(context),
            const SizedBox(height: 24),
            _buildRecentPractices(),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeModes(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Practice Modes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              PracticeCard(
                title: 'Take a Quiz',
                description: 'Test your knowledge with interactive quizzes',
                icon: Icons.quiz,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(
                        language: 'Spanish',
                        level: 'Beginner',
                        questionCount: 10,
                      ),
                    ),
                  );
                },
              ),
              PracticeCard(
                title: 'Speaking Practice',
                description: 'Practice pronunciation with voice recognition',
                icon: Icons.mic,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coming soon!'),
                    ),
                  );
                },
              ),
              PracticeCard(
                title: 'Writing Practice',
                description: 'Improve your writing skills with exercises',
                icon: Icons.edit,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coming soon!'),
                    ),
                  );
                },
              ),
              PracticeCard(
                title: 'Vocabulary',
                description: 'Learn new words',
                icon: AppIcons.vocabulary,
                onTap: () {
                  // Handle vocabulary practice
                },
              ),
              PracticeCard(
                title: 'Grammar',
                description: 'Master grammar rules',
                icon: AppIcons.grammar,
                onTap: () {
                  // Handle grammar practice
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return PracticeCard(
      title: title,
      description: description,
      icon: icon,
      onTap: onTap,
    );
  }

  Widget _buildRecentPractices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Practices',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildPracticeHistoryItem(
            'Speaking Practice',
            'Spanish - Greetings',
            '10 minutes ago',
            AppIcons.speak,
            Colors.orange,
          ),
          _buildPracticeHistoryItem(
            'Vocabulary Quiz',
            'German - Food',
            '1 hour ago',
            AppIcons.vocabulary,
            Colors.green,
          ),
          _buildPracticeHistoryItem(
            'Grammar Exercise',
            'English - Tenses',
            '2 hours ago',
            AppIcons.grammar,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeHistoryItem(
    String title,
    String subtitle,
    String time,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        onTap: () {
          // Handle practice history item tap
        },
      ),
    );
  }
}

class PracticeCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const PracticeCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
