import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/course_level.dart';
import 'lesson_detail_screen.dart';
import 'package:easy_talk/services/theme_service.dart';

class CourseDetailScreen extends StatelessWidget {
  final CourseLevel course;
  final Map<String, dynamic>? userProgress;

  const CourseDetailScreen({
    Key? key,
    required this.course,
    this.userProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);
    final completedLessons =
        userProgress?['completedLessons'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              course.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.description,
                    style: theme.bodyStyle,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Lessons',
                    style: theme.titleStyle,
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: course.lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = course.lessons[index];
                      final isCompleted = completedLessons.contains(lesson.id);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isCompleted
                                ? theme.successColor
                                : theme.primaryColor,
                            child: Icon(
                              isCompleted ? Icons.check : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            lesson.title,
                            style: theme.subtitleStyle,
                          ),
                          subtitle: Text(
                            lesson.description,
                            style: theme.captionStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: theme.subtitleColor,
                          ),
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
          ],
        ),
      ),
    );
  }
}
