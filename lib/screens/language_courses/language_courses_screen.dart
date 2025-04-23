import 'package:flutter/material.dart';
import '../../data/english_courses.dart';
import '../../data/spanish_courses.dart';
import '../../models/language_course.dart';
import 'lesson_detail_screen.dart';

class LanguageCoursesScreen extends StatelessWidget {
  final String language;

  const LanguageCoursesScreen({
    super.key,
    required this.language,
  });

  List<LanguageCourse> get courses {
    switch (language.toLowerCase()) {
      case 'english':
        return englishCourses;
      case 'spanish':
        return spanishCourses;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$language Courses'),
      ),
      body: courses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No courses available for $language yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please check back later',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return CourseCard(course: course);
              },
            ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final LanguageCourse course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder for course image
          Container(
            height: 200,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                course.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  course.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: Text(course.level),
                      backgroundColor: Colors.blue[100],
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('${course.lessons.length} Lessons'),
                      backgroundColor: Colors.green[100],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LessonDetailScreen(
                          lesson: course.lessons[0], // Show first lesson initially
                        ),
                      ),
                    );
                  },
                  child: const Text('Start Learning'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 