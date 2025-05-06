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
    // Dummy progress for now (replace with real progress if available)
    double progress = 0.0;
    int lessonCount = course.lessons.length;
    String level = course.level;
    bool isAdvanced = level.toLowerCase() == 'advanced';

    return Scaffold(
      appBar: AppBar(
        title: Text('${course.title}'),
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: isAdvanced ? Colors.grey[900] : Colors.grey[850],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (isAdvanced)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.star, color: Colors.white, size: 18),
                                SizedBox(width: 4),
                                Text('Advanced',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      course.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[700],
                      color: isAdvanced ? Colors.red : Colors.orange,
                      minHeight: 6,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}% Complete',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                        Text(
                          '$lessonCount Lessons',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isAdvanced ? Colors.red : Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        label: const Text('Continue Learning',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: lessonCount > 0
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonDetailScreen(
                                      lesson: course.lessons[0],
                                      courseId: course.id,
                                    ),
                                  ),
                                );
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Optionally, add more content below (e.g., lesson list)
          ],
        ),
      ),
    );
  }
}
