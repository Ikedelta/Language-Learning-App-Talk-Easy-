import 'package:flutter/material.dart';
import '../widgets/generate_course_button.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final String userId;

  const LanguageSelectionScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  void _showMessage(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Language'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select a language to generate a course:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildLanguageCard(
            context,
            'Spanish',
            'Learn one of the most spoken languages in the world',
            Icons.language,
          ),
          const SizedBox(height: 16),
          _buildLanguageCard(
            context,
            'French',
            'Master the language of love and culture',
            Icons.language,
          ),
          const SizedBox(height: 16),
          _buildLanguageCard(
            context,
            'German',
            'Explore the language of innovation and philosophy',
            Icons.language,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(
    BuildContext context,
    String language,
    String description,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32),
                const SizedBox(width: 16),
                Text(
                  language,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Center(
              child: GenerateCourseButton(
                userId: userId,
                language: language,
                level: 'beginner',
                onSuccess: (message) => _showMessage(context, message, false),
                onError: (error) => _showMessage(context, error, true),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 