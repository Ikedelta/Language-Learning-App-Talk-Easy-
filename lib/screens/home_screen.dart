import 'package:flutter/material.dart';
import '../utils/app_icons.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Talk'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.notification),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(),
            const SizedBox(height: 24),
            _buildQuickActions(context),
            const SizedBox(height: 24),
            _buildContinueLearning(context),
            const SizedBox(height: 24),
            _buildDailyGoals(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back, John!',
            style: TextStyle(
              color: AppTheme.onPrimary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Continue your language learning journey',
            style: TextStyle(
              color: AppTheme.onPrimary.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildHeaderStat(
                AppIcons.streak,
                '7',
                'Day Streak',
              ),
              _buildHeaderStat(
                AppIcons.score,
                '850',
                'XP Points',
              ),
              _buildHeaderStat(
                AppIcons.achievement,
                '12',
                'Achievements',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppTheme.onPrimary,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppTheme.onPrimary.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(
                context,
                'Practice Speaking',
                AppIcons.speak,
                Colors.orange,
              ),
              _buildActionButton(
                context,
                'Take a Quiz',
                AppIcons.quiz,
                Colors.purple,
              ),
              _buildActionButton(
                context,
                'Learn Grammar',
                AppIcons.grammar,
                Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.1),
          child: IconButton(
            icon: Icon(icon, color: color),
            onPressed: () {
              // Handle action button tap
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContinueLearning(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Continue Learning',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCourseCard(
                  'Spanish Basics',
                  'Lesson 3: Greetings',
                  '60%',
                  AppIcons.spanishFlag,
                  AppTheme.beginner,
                ),
                _buildCourseCard(
                  'English Grammar',
                  'Advanced Tenses',
                  '40%',
                  AppIcons.englishFlag,
                  AppTheme.advanced,
                ),
                _buildCourseCard(
                  'German Vocabulary',
                  'Food and Drinks',
                  '25%',
                  AppIcons.germanFlag,
                  AppTheme.intermediate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
    String title,
    String subtitle,
    String progress,
    String flag,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  flag,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: double.parse(progress.replaceAll('%', '')) / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  progress,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyGoals(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Goals',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildGoalItem(
                    'Complete 3 Lessons',
                    '2/3',
                    0.67,
                    AppIcons.lesson,
                    AppTheme.primaryColor,
                  ),
                  const Divider(),
                  _buildGoalItem(
                    'Practice Speaking',
                    '10/15 min',
                    0.67,
                    AppIcons.speak,
                    Colors.orange,
                  ),
                  const Divider(),
                  _buildGoalItem(
                    'Learn New Words',
                    '8/10',
                    0.8,
                    AppIcons.vocabulary,
                    Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalItem(
    String title,
    String progress,
    double value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            progress,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
