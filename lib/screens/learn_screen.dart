import 'package:flutter/material.dart';
import '../utils/app_icons.dart';
import '../utils/app_theme.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLanguageSelector(),
            const SizedBox(height: 24),
            _buildLevelsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildLanguageCard(
            'Spanish',
            AppIcons.spanishFlag,
            AppTheme.primaryColor,
            true,
          ),
          _buildLanguageCard(
            'English',
            AppIcons.englishFlag,
            Colors.blue,
            false,
          ),
          _buildLanguageCard(
            'German',
            AppIcons.germanFlag,
            Colors.orange,
            false,
          ),
          _buildLanguageCard(
            'Japanese',
            AppIcons.japaneseFlag,
            Colors.red,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(
    String language,
    String flag,
    Color color,
    bool isSelected,
  ) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            flag,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          Text(
            language,
            style: TextStyle(
              color: isSelected ? color : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Levels',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildLevelCard(
            'Beginner',
            'Learn basic vocabulary and phrases',
            '0/10 Lessons',
            0.0,
            AppTheme.beginner,
            true,
          ),
          _buildLevelCard(
            'Elementary',
            'Master essential grammar and conversation',
            '0/15 Lessons',
            0.0,
            AppTheme.intermediate,
            false,
          ),
          _buildLevelCard(
            'Intermediate',
            'Improve fluency and comprehension',
            '0/20 Lessons',
            0.0,
            AppTheme.advanced,
            false,
          ),
          _buildLevelCard(
            'Advanced',
            'Perfect your language skills',
            '0/25 Lessons',
            0.0,
            Colors.purple,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(
    String title,
    String description,
    String progress,
    double value,
    Color color,
    bool isUnlocked,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    progress,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: isUnlocked
                      ? () {
                          // Handle start learning
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(isUnlocked ? 'Start' : 'Locked'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
