import 'package:flutter/material.dart';
import '../utils/app_icons.dart';
import '../utils/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.settings),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStatisticsSection(context),
            const SizedBox(height: 24),
            _buildAchievementsSection(context),
            const SizedBox(height: 24),
            _buildLanguageProgress(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
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
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://ui-avatars.com/api/?name=John+Doe&background=random',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              color: AppTheme.onPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Language Enthusiast',
            style: TextStyle(
              color: AppTheme.onPrimary.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStat('850', 'XP Points'),
              _buildProfileStat('7', 'Day Streak'),
              _buildProfileStat('3', 'Languages'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.onPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppTheme.onPrimary.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard(
                    context,
                    AppIcons.quiz,
                    '42',
                    'Quizzes\nCompleted',
                  ),
                  _buildStatCard(
                    context,
                    AppIcons.score,
                    '89%',
                    'Average\nScore',
                  ),
                  _buildStatCard(
                    context,
                    AppIcons.achievement,
                    '12',
                    'Achievements\nEarned',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAchievementsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Achievements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildAchievementCard(
                  'Perfect Score',
                  '100% on Advanced Quiz',
                  AppIcons.achievement,
                  AppTheme.gold,
                ),
                _buildAchievementCard(
                  'Quick Learner',
                  'Completed 5 lessons in a day',
                  AppIcons.lesson,
                  AppTheme.silver,
                ),
                _buildAchievementCard(
                  'Conversation Master',
                  'Completed 10 speaking exercises',
                  AppIcons.speak,
                  AppTheme.bronze,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageProgress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Language Progress',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _buildLanguageProgressItem(
                  'English',
                  0.8,
                  AppIcons.englishFlag,
                  'Advanced',
                ),
                const Divider(),
                _buildLanguageProgressItem(
                  'Spanish',
                  0.6,
                  AppIcons.spanishFlag,
                  'Intermediate',
                ),
                const Divider(),
                _buildLanguageProgressItem(
                  'German',
                  0.3,
                  AppIcons.germanFlag,
                  'Beginner',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageProgressItem(
    String language,
    double progress,
    String flag,
    String level,
  ) {
    return ListTile(
      leading: Text(
        flag,
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(language),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.primaryColor,
            ),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 4),
          Text(level),
        ],
      ),
      trailing: Text('${(progress * 100).round()}%'),
    );
  }
}
