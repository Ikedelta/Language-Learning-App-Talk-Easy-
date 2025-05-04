import 'package:flutter/material.dart';
import 'package:easy_talk/models/language_course.dart';
import 'lesson_detail_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final LanguageCourse course;

  const CourseDetailScreen({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Chip(
                  label: Text(course.level),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(width: 8),
                Text(
                  '${course.lessons.length} lessons',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Lessons',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: course.lessons.length,
              itemBuilder: (context, index) {
                final lesson = course.lessons[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(lesson.title),
                    subtitle: Text(lesson.description),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonDetailScreen(
                            lesson: lesson,
                            courseId: course.id,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
