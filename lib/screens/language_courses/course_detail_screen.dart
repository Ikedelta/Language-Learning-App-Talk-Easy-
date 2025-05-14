import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/model_types.dart' show Course;
import 'lesson_detail_screen.dart';
import 'package:easy_talk/services/theme_service.dart';
import '../../providers/course_provider.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;

  const CourseDetailScreen({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  void initState() {
    super.initState();
    _loadCourse();
  }

  Future<void> _loadCourse() async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    await courseProvider.loadCourseById(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Consumer<CourseProvider>(
          builder: (context, courseProvider, child) {
            final course = courseProvider.currentCourse;
            return Text(course?.name ?? 'Course Details');
          },
        ),
        backgroundColor: theme.primaryColor,
      ),
      body: Consumer<CourseProvider>(
        builder: (context, courseProvider, child) {
          if (courseProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (courseProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    courseProvider.error!,
                    style: theme.errorTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadCourse,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final course = courseProvider.currentCourse;
          if (course == null) {
            return const Center(
              child: Text('Course not found'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  color: theme.primaryColor.withOpacity(0.1),
                  child: Center(
                    child: Icon(
                      Icons.school,
                      size: 64,
                      color: theme.primaryColor,
                    ),
                  ),
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
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: theme.primaryColor,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white),
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
                                      language: course.language,
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
          );
        },
      ),
    );
  }
}
