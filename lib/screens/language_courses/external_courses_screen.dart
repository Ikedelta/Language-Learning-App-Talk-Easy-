import 'package:flutter/material.dart';
import 'package:easy_talk/services/external_courses_service.dart';
import 'package:easy_talk/models/external_course.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalCoursesScreen extends StatefulWidget {
  final String language;

  const ExternalCoursesScreen({
    super.key,
    required this.language,
  });

  @override
  State<ExternalCoursesScreen> createState() => _ExternalCoursesScreenState();
}

class _ExternalCoursesScreenState extends State<ExternalCoursesScreen> {
  final _externalCoursesService = ExternalCoursesService();
  List<ExternalCourse> _courses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      final courses =
          await _externalCoursesService.getExternalCourses(widget.language);
      setState(() {
        _courses = courses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading courses: $e')),
        );
      }
    }
  }

  Future<void> _launchCourse(ExternalCourse course) async {
    final Uri url = Uri.parse(course.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch the course')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_courses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No external courses available for ${widget.language}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _courses.length,
      itemBuilder: (context, index) {
        final course = _courses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _launchCourse(course),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          course.thumbnailUrl,
                          width: 120,
                          height: 68,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 120,
                              height: 68,
                              color: Colors.grey[300],
                              child: const Icon(Icons.video_library),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              course.instructor,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    course.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.timer_outlined,
                        label: '${course.duration} min',
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: Icons.school_outlined,
                        label: course.level,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: Icons.star_outline,
                        label:
                            '${course.rating.toStringAsFixed(1)} (${course.ratingCount})',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Platform: ${course.platform}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Chip(
      label: Text(label),
      avatar: Icon(icon, size: 16),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
