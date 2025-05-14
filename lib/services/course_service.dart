import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course_model.dart' as course_model;
import '../models/model_types.dart' show Exercise, VocabItem, Lesson;
import '../models/course_level.dart';
import '../models/language_course.dart';
import 'package:uuid/uuid.dart';
import '../data/english_courses.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_talk/services/logger_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../utils/logger.dart';
import '../utils/model_converters.dart';
import '../config/api_config.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  CourseService() {
    AppLogger.info('Initializing CourseService with API key: ${ApiConfig.isGeminiConfigured ? 'PRESENT' : 'EMPTY'}');
    if (!ApiConfig.isGeminiConfigured) {
      AppLogger.error('API key is empty. Please check your .env file.');
    }
  }

  // Initialize courses in Firestore
  Future<void> initializeCourses() async {
    try {
      // Check if courses already exist
      final coursesSnapshot = await _firestore.collection('courses').get();
      if (coursesSnapshot.docs.isNotEmpty) {
        AppLogger.info('Courses already initialized: ${coursesSnapshot.docs.length} courses found');
        return; // Courses already initialized
      }

      AppLogger.info('No courses found, initializing default courses');
      // Add English courses
      for (final course in englishCourses) {
        await _firestore
            .collection('courses')
            .doc(course.id)
            .set(course.toJson());
        AppLogger.info('Added course: ${course.id}');
      }
    } catch (e) {
      AppLogger.error('Error initializing courses', e);
      rethrow;
    }
  }

  // Stream course levels for a language
  Stream<List<CourseLevel>> watchCourseLevelsByLanguage(String language) {
    try {
      AppLogger.info('Starting to watch courses for language: ${language.toLowerCase()}');
      
      // First check if we have any courses
      _firestore.collection('courses').get().then((snapshot) {
        AppLogger.info('Total courses in Firestore: ${snapshot.docs.length}');
        if (snapshot.docs.isEmpty) {
          // Initialize sample courses if none exist
          initializeCourses().then((_) {
            AppLogger.info('Initialized sample courses');
          }).catchError((error) {
            AppLogger.error('Failed to initialize courses', error);
          });
        }
      }).catchError((error) {
        AppLogger.error('Failed to check courses', error);
      });

      return _firestore
          .collection('courses')
          .where('language', isEqualTo: language.toLowerCase())
          .orderBy('level')
          .snapshots()
          .map((snapshot) {
            AppLogger.info('Received snapshot with ${snapshot.docs.length} documents');
            if (snapshot.docs.isEmpty) {
              AppLogger.info('No courses found for language: ${language.toLowerCase()}');
              // Add sample course content for this language
              addSampleCourseContent(language).then((_) {
                AppLogger.info('Added sample courses for $language');
              }).catchError((error) {
                AppLogger.error('Failed to add sample courses', error);
              });
            }
            return snapshot.docs.map((doc) {
              final data = doc.data();
              AppLogger.info('Processing document ${doc.id}: ${data['title']}');

              // Convert the level string to a number
              final levelStr = (data['level'] as String? ?? 'beginner').toLowerCase();
              int levelNumber;
              switch (levelStr) {
                case 'beginner':
                  levelNumber = 1;
                  break;
                case 'intermediate':
                  levelNumber = 2;
                  break;
                case 'advanced':
                  levelNumber = 3;
                  break;
                default:
                  levelNumber = 1;
              }

              AppLogger.info('Converting level "$levelStr" to number: $levelNumber');

              // Convert exercises to the CourseLevel format
              final exercises = (data['exercises'] as List? ?? []).map((exercise) {
                return Exercise(
                  id: exercise['id'] ?? _uuid.v4(),
                  type: exercise['type'] ?? 'multiple_choice',
                  question: exercise['question'] ?? '',
                  options: List<String>.from(exercise['options'] ?? []),
                  correctAnswer: exercise['correctAnswer'] ?? '',
                  explanation: exercise['explanation'] ?? '',
                  answer: exercise['answer'] ?? exercise['correctAnswer'] ?? '',
                );
              }).toList();

              AppLogger.info('Converted ${exercises.length} exercises');

              // Convert vocabulary to VocabItem objects
              final vocabulary = (data['vocabulary'] as List? ?? []).map((item) {
                if (item is String) {
                  return VocabItem(
                    word: item,
                    translation: '', // Default empty translation
                    pronunciation: '', // Default empty pronunciation
                  );
                }
                return VocabItem(
                  word: item['word'] as String? ?? '',
                  translation: item['translation'] as String? ?? '',
                  pronunciation: item['pronunciation'] as String? ?? '',
                );
              }).toList();

              // Create a lesson from the course data
              final lesson = Lesson(
                id: doc.id,
                title: data['title'] ?? '',
                description: data['description'] ?? '',
                vocabulary: vocabulary,
                grammarPoints: (data['grammarPoints'] as List? ?? [])
                    .map((point) => point is String ? point : point['title'] as String)
                    .toList(),
                exercises: exercises,
                duration: 30, // Default duration
                difficulty: levelStr,
                audioUrl: data['audioUrl'] ?? '',
                videoUrl: data['videoUrl'] ?? '',
                notes: '',
              );

              AppLogger.info('Created lesson with ${lesson.vocabulary.length} vocabulary items and ${lesson.grammarPoints.length} grammar points');

              return CourseLevel(
                id: doc.id,
                name: data['title'] ?? '',
                description: data['description'] ?? '',
                level: levelNumber,
                language: data['language'] ?? '',
                imageUrl: 'assets/images/${levelStr}_${language.toLowerCase()}.png',
                isLocked: false,
                requiredXp: levelNumber == 1 ? 0 : (levelNumber - 1) * 100,
                lessons: [lesson],
              );
            }).toList();
          })
          .handleError((error) {
            AppLogger.error('Error in course stream', error);
            return [];
          });
    } catch (e, stackTrace) {
      AppLogger.error('Error in watchCourseLevelsByLanguage', e, stackTrace);
      return Stream.value([]);
    }
  }

  int _getLevelNumber(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return 1;
      case 'intermediate':
        return 2;
      case 'advanced':
        return 3;
      default:
        return 1;
    }
  }

  Stream<List<LanguageCourse>> getAllCourses() {
    return _firestore.collection('courses').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return LanguageCourse(
          id: doc.id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          level: data['level'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          language: data['language'] ?? '',
          lessons: (data['lessons'] as List?)?.map((lesson) {
                return CourseLesson(
                  id: lesson['id'] ?? '',
                  title: lesson['title'] ?? '',
                  description: lesson['description'] ?? '',
                  vocabulary: List<String>.from(lesson['vocabulary'] ?? []),
                  grammarPoints:
                      List<String>.from(lesson['grammarPoints'] ?? []),
                  exercises: List<String>.from(lesson['exercises'] ?? []),
                  audioUrl: lesson['audioUrl'] ?? '',
                  videoUrl: lesson['videoUrl'] ?? '',
                  notes: lesson['notes'] ?? '',
                );
              }).toList() ??
              [],
        );
      }).toList();
    });
  }

  // Get all course levels for a specific language
  Future<List<CourseLevel>> getCourseLevels(String language) async {
    try {
      final snapshot = await _firestore
          .collection('courses')
          .where('language', isEqualTo: language.toLowerCase())
          .orderBy('level')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return CourseLevel(
          id: doc.id,
          name: data['title'] ?? data['name'] ?? '',
          description: data['description'] ?? '',
          level: data['level'] is int
              ? data['level']
              : _getLevelNumber(data['level']),
          language: data['language'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          isLocked: data['isLocked'] ?? true,
          requiredXp: data['requiredXp'] ?? 0,
          lessons: (data['lessons'] as List?)?.map((lesson) {
                return Lesson(
                  id: lesson['id'] ?? '',
                  title: lesson['title'] ?? '',
                  description: lesson['description'] ?? '',
                  vocabulary: (lesson['vocabulary'] as List?)?.map((item) {
                    if (item is String) {
                      return VocabItem(
                        word: item,
                        translation: '',
                        pronunciation: '',
                      );
                    }
                    return VocabItem.fromJson(item as Map<String, dynamic>);
                  }).toList() ?? [],
                  grammarPoints: List<String>.from(lesson['grammarPoints'] ?? []),
                  exercises: (lesson['exercises'] as List?)?.map((e) => Exercise.fromJson(e as Map<String, dynamic>)).toList() ?? [],
                  audioUrl: lesson['audioUrl'] ?? '',
                  videoUrl: lesson['videoUrl'] ?? '',
                  notes: lesson['notes'] ?? '',
                );
              }).toList() ?? [],
        );
      }).toList();
    } catch (e) {
      AppLogger.error('Error in getCourseLevels', e);
      rethrow;
    }
  }

  // Get a specific course level
  Future<CourseLevel?> getCourseLevel(String language, String levelId) async {
    try {
      final doc = await _firestore
          .collection('courses')
          .doc(language.toLowerCase())
          .collection('levels')
          .doc(levelId)
          .get();

      if (!doc.exists) return null;
      return CourseLevel.fromJson(doc.data()!);
    } catch (e) {
      print('Error getting course level: $e');
      rethrow;
    }
  }

  // Get a specific lesson
  Future<course_model.Lesson?> getLesson(
      String language, String levelId, String lessonId) async {
    try {
      final doc = await _firestore
          .collection('courses')
          .doc(language.toLowerCase())
          .collection('levels')
          .doc(levelId)
          .collection('lessons')
          .doc(lessonId)
          .get();

      if (!doc.exists) return null;
      return course_model.Lesson.fromJson(doc.data()!);
    } catch (e) {
      print('Error getting lesson: $e');
      rethrow;
    }
  }

  // Mark a lesson as completed
  Future<void> completeLesson(
    String userId,
    String language,
    String levelId,
    String lessonId,
  ) async {
    try {
      final userProgressRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(language.toLowerCase());

      await _firestore.runTransaction((transaction) async {
        final userProgressDoc = await transaction.get(userProgressRef);
        final Map<String, dynamic> progressData;

        if (!userProgressDoc.exists) {
          progressData = {
            'enrolledCourses': [levelId],
            'completedLessons': [lessonId],
            'totalScore': 0,
            'lastAccessed': FieldValue.serverTimestamp(),
          };
        } else {
          progressData = userProgressDoc.data()!;
          final completedLessons =
              List<String>.from(progressData['completedLessons'] ?? []);
          if (!completedLessons.contains(lessonId)) {
            completedLessons.add(lessonId);
            progressData['completedLessons'] = completedLessons;
          }
          progressData['lastAccessed'] = FieldValue.serverTimestamp();
        }

        transaction.set(userProgressRef, progressData, SetOptions(merge: true));
      });
    } catch (e) {
      throw Exception('Failed to complete lesson: $e');
    }
  }

  // Get user progress for a specific language
  Future<Map<String, dynamic>> getUserProgress(
      String userId, String language) async {
    try {
      final userProgressRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(language.toLowerCase());

      final userProgressDoc = await userProgressRef.get();
      if (!userProgressDoc.exists) {
        return {
          'enrolledCourses': [],
          'completedLessons': [],
          'totalScore': 0,
          'lastAccessed': null,
          'completionPercentage': 0.0,
        };
      }

      final data = userProgressDoc.data()!;
      final enrolledCourses = List<String>.from(data['enrolledCourses'] ?? []);
      final completedLessons =
          List<String>.from(data['completedLessons'] ?? []);
      final totalScore = data['totalScore'] ?? 0;
      final lastAccessed = data['lastAccessed'];

      // Calculate completion percentage
      double completionPercentage = 0.0;
      if (enrolledCourses.isNotEmpty) {
        int totalLessons = 0;
        int completedLessonsCount = 0;

        for (final courseId in enrolledCourses) {
          final courseDoc = await _firestore
              .collection('courses')
              .doc(language.toLowerCase())
              .collection('levels')
              .doc(courseId)
              .get();

          if (courseDoc.exists) {
            final courseData = courseDoc.data()!;
            final lessons =
                List<Map<String, dynamic>>.from(courseData['lessons'] ?? []);
            totalLessons += lessons.length;
            completedLessonsCount += lessons
                .where((lesson) => completedLessons.contains(lesson['id']))
                .length;
          }
        }

        if (totalLessons > 0) {
          completionPercentage = (completedLessonsCount / totalLessons) * 100;
        }
      }

      return {
        'enrolledCourses': enrolledCourses,
        'completedLessons': completedLessons,
        'totalScore': totalScore,
        'lastAccessed': lastAccessed,
        'completionPercentage': completionPercentage,
      };
    } catch (e) {
      throw Exception('Failed to get user progress: $e');
    }
  }

  // Enroll user in a course
  Future<void> enrollInCourse(
      String userId, String language, String courseId) async {
    try {
      final userProgressRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(language.toLowerCase());

      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(userProgressRef);
        if (!doc.exists) {
          // Create new progress document
          transaction.set(userProgressRef, {
            'enrolledCourses': [courseId],
            'completedLessons': [],
            'totalScore': 0,
            'lastAccessed': FieldValue.serverTimestamp(),
          });
        } else {
          // Update existing progress
          final enrolledCourses =
              List<String>.from(doc.data()?['enrolledCourses'] ?? []);
          if (!enrolledCourses.contains(courseId)) {
            enrolledCourses.add(courseId);
            transaction.update(userProgressRef, {
              'enrolledCourses': enrolledCourses,
              'lastAccessed': FieldValue.serverTimestamp(),
            });
          }
        }
      });
    } catch (e) {
      print('Error enrolling in course: $e');
      rethrow;
    }
  }

  // Update user progress
  Future<void> updateUserProgress(
    String userId,
    String language,
    String courseId,
    String lessonId,
    int score,
  ) async {
    try {
      final userProgressRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(language.toLowerCase());

      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(userProgressRef);
        if (doc.exists) {
          final data = doc.data()!;
          final completedLessons =
              List<String>.from(data['completedLessons'] ?? []);
          if (!completedLessons.contains(lessonId)) {
            completedLessons.add(lessonId);
            final totalScore = (data['totalScore'] ?? 0) + score;
            transaction.update(userProgressRef, {
              'completedLessons': completedLessons,
              'totalScore': totalScore,
              'lastAccessed': DateTime.now().toIso8601String(),
            });
          }
        }
      });
    } catch (e) {
      print('Error updating user progress: $e');
      rethrow;
    }
  }

  // Add sample course content (for development)
  Future<void> addSampleCourseContent(String language) async {
    try {
      // Check if courses already exist for this language
      final coursesSnapshot = await _firestore
          .collection('courses')
          .where('language', isEqualTo: language.toLowerCase())
          .get();

      if (coursesSnapshot.docs.isNotEmpty) {
        return; // Courses already exist for this language
      }

      // Create sample courses
      final courses = [
        course_model.Course(
          id: _uuid.v4(),
          name: 'Beginner ${language}',
          title: 'Beginner ${language}',
          description: 'Start your journey with basic vocabulary and grammar',
          language: language.toLowerCase(),
          level: 'beginner',
          userId: 'system',
          createdAt: DateTime.now(),
          lessons: [
            course_model.Lesson(
              id: _uuid.v4(),
              title: 'Basic Greetings',
              description: 'Learn essential greetings and introductions',
              vocabulary: [
                course_model.VocabItem(
                  word: 'Hello',
                  translation: 'Basic greeting',
                  pronunciation: 'heh-loh',
                ),
                course_model.VocabItem(
                  word: 'Goodbye',
                  translation: 'Basic farewell',
                  pronunciation: 'good-bahy',
                ),
              ],
              dialogue: 'A: Hello!\nB: Hi, how are you?\nA: I am fine, thank you!',
              grammarPoints: ['Basic sentence structure', 'Formal vs informal greetings'],
              exercises: [
                course_model.Exercise(
                  id: _uuid.v4(),
                  type: 'multiple_choice',
                  question: 'How do you say "Hello"?',
                  options: ['Hi', 'Goodbye', 'Thank you', 'Please'],
                  correctAnswer: 'Hi',
                  explanation: 'Hi is another way to say Hello',
                  answer: 'Hi',
                ),
              ],
            ),
          ],
        ),
        course_model.Course(
          id: _uuid.v4(),
          name: 'Intermediate ${language}',
          title: 'Intermediate ${language}',
          description: 'Advance your language skills with more complex topics',
          language: language.toLowerCase(),
          level: 'intermediate',
          userId: 'system',
          createdAt: DateTime.now(),
          lessons: [
            course_model.Lesson(
              id: _uuid.v4(),
              title: 'Advanced Conversation',
              description: 'Master complex conversation patterns',
              vocabulary: [
                course_model.VocabItem(
                  word: 'Nevertheless',
                  translation: 'However/Despite that',
                  pronunciation: 'nev-er-thuh-les',
                ),
              ],
              dialogue: 'A: The weather is bad. Nevertheless, shall we go for a walk?\nB: Yes, let\'s take umbrellas.',
              grammarPoints: ['Past tense usage', 'Complex sentence structure'],
              exercises: [
                course_model.Exercise(
                  id: _uuid.v4(),
                  type: 'fill_blank',
                  question: 'Yesterday, I ____ to the store.',
                  options: ['go', 'went', 'going', 'goes'],
                  correctAnswer: 'went',
                  explanation: 'Use went for past tense of go',
                  answer: 'went',
                ),
              ],
            ),
          ],
        ),
        course_model.Course(
          id: _uuid.v4(),
          name: 'Advanced ${language}',
          title: 'Advanced ${language}',
          description: 'Master complex grammar and idiomatic expressions',
          language: language.toLowerCase(),
          level: 'advanced',
          userId: 'system',
          createdAt: DateTime.now(),
          lessons: [
            course_model.Lesson(
              id: _uuid.v4(),
              title: 'Idiomatic Expressions',
              description: 'Learn common idiomatic expressions',
              vocabulary: [
                course_model.VocabItem(
                  word: 'Serendipity',
                  translation: 'A happy accident',
                  pronunciation: 'ser-uhn-dip-i-tee',
                ),
              ],
              dialogue: 'A: Finding this book was pure serendipity!\nB: Yes, what a lucky coincidence!',
              grammarPoints: ['Subjunctive mood', 'Conditional sentences'],
              exercises: [
                course_model.Exercise(
                  id: _uuid.v4(),
                  type: 'multiple_choice',
                  question: 'Which is the correct subjunctive form?',
                  options: ['If I was', 'If I were', 'If I be', 'If I am'],
                  correctAnswer: 'If I were',
                  explanation: 'Use were in the subjunctive mood',
                  answer: 'If I were',
                ),
              ],
            ),
          ],
        ),
      ];

      // Save all courses to Firestore
      final batch = _firestore.batch();
      for (var course in courses) {
        final courseRef = _firestore.collection('courses').doc(course.id);
        batch.set(courseRef, course.toJson());
      }
      await batch.commit();

    } catch (e) {
      AppLogger.error('Error adding sample course content', e);
      rethrow;
    }
  }

  Future<course_model.Course> generateCourse({
    required String userId,
    required String language,
    required String level,
  }) async {
    try {
      AppLogger.info('Starting course generation for $language at $level level');
      
      // Check for existing course
      final hasExisting = await hasExistingCourses(userId, language);
      if (hasExisting) {
        AppLogger.info('Found existing course for $language');
      }

      if (!ApiConfig.isGeminiConfigured) {
        AppLogger.error('Gemini API key not configured');
        throw Exception('Gemini API key not configured. Please check your .env file.');
      }

      final course = await _generateCourseContent(language, level, userId);
      AppLogger.info('Course generated successfully, saving to Firestore...');

      // Save to Firestore
      await _firestore.collection('courses').doc(course.id).set(course.toJson());
      AppLogger.info('Course saved to Firestore with ID: ${course.id}');

      return course;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate course', e, stackTrace);
      rethrow;
    }
  }

  Future<void> _saveCourseToFirestore(course_model.Course course) async {
    try {
      await _firestore.collection('courses').doc(course.id).set(course.toJson());
    } catch (e, stackTrace) {
      AppLogger.error('Error saving course to Firestore', e, stackTrace);
      // Don't rethrow - we still want to return the course even if saving fails
    }
  }

  // Fetch courses by language
  Future<List<course_model.Course>> fetchCoursesByLanguage(String language) async {
    try {
      AppLogger.info('Fetching courses for language: ${language.toLowerCase()}');
      
      final snapshot = await _firestore
          .collection('courses')
          .where('language', isEqualTo: language.toLowerCase())
          .orderBy('createdAt', descending: true)
          .get();

      AppLogger.info('Found ${snapshot.docs.length} courses for language: $language');
      
      final courses = snapshot.docs
          .map((doc) => course_model.Course.fromJson(doc.data()))
          .toList();

      AppLogger.info('Successfully converted ${courses.length} courses from Firestore');
      return courses;
    } catch (e, stackTrace) {
      AppLogger.error('Error fetching courses by language', e, stackTrace);
      rethrow;
    }
  }

  Future<List<course_model.Course>> getCoursesByLevel(String level) async {
    try {
      final snapshot = await _firestore
          .collection('courses')
          .where('level', isEqualTo: level)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => course_model.Course.fromJson(doc.data()))
          .toList();
    } catch (e, stackTrace) {
      AppLogger.error('Error fetching courses', e, stackTrace);
      rethrow;
    }
  }

  Future<course_model.Course?> getCourseById(String courseId) async {
    try {
      final doc = await _firestore
          .collection('courses')
          .doc(courseId)
          .get();

      if (!doc.exists) {
        return null;
      }

      return course_model.Course.fromJson(doc.data()!);
    } catch (e, stackTrace) {
      AppLogger.error('Error fetching course', e, stackTrace);
      rethrow;
    }
  }

  // Check if user has existing courses
  Future<bool> hasExistingCourses(String userId, String language) async {
    try {
      final snapshot = await _firestore
          .collection('courses')
          .where('userId', isEqualTo: userId)
          .where('language', isEqualTo: language.toLowerCase())
          .get();
      
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      AppLogger.error('Error checking existing courses', e);
      rethrow;
    }
  }

  // Get user's courses
  Stream<List<course_model.Course>> watchUserCourses(String userId) {
    try {
      return _firestore
          .collection('courses')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => course_model.Course.fromJson(doc.data()))
              .toList());
    } catch (e) {
      AppLogger.error('Error watching user courses', e);
      return Stream.value([]);
    }
  }

  // Get a specific course
  Future<course_model.Course?> getCourse(String courseId) async {
    try {
      final doc = await _firestore.collection('courses').doc(courseId).get();
      if (!doc.exists) return null;
      return course_model.Course.fromJson(doc.data()!);
    } catch (e) {
      AppLogger.error('Error getting course', e);
      rethrow;
    }
  }

  Future<bool> hasExistingCourse(String userId, String language) async {
    try {
      final querySnapshot = await _firestore
          .collection('courses')
          .where('userId', isEqualTo: userId)
          .where('language', isEqualTo: language.toLowerCase())
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      AppLogger.error('Error checking existing course', e);
      rethrow;
    }
  }

  // Convert Course to CourseLevel
  CourseLevel _convertToCourseLevel(course_model.Course course) {
    return CourseLevel(
      id: course.id,
      name: course.name,
      description: course.description,
      level: _getLevelNumber(course.level),
      language: course.language,
      imageUrl: 'assets/images/${course.level.toLowerCase()}_${course.language.toLowerCase()}.png',
      isLocked: false,
      requiredXp: _getLevelNumber(course.level) == 1 ? 0 : (_getLevelNumber(course.level) - 1) * 100,
      lessons: course.lessons.map((lesson) => Lesson(
        id: lesson.id,
        title: lesson.title,
        description: lesson.description,
        vocabulary: lesson.vocabulary.map((word) => VocabItem(
          word: word.word,
          translation: word.translation,
          pronunciation: word.pronunciation,
        )).toList(),
        grammarPoints: lesson.grammarPoints,
        exercises: lesson.exercises.map((ex) => Exercise(
          id: ex.id,
          type: ex.type,
          question: ex.question,
          options: ex.options,
          correctAnswer: ex.correctAnswer,
          explanation: ex.explanation,
          answer: ex.answer ?? ex.correctAnswer,
        )).toList(),
        duration: lesson.duration,
        difficulty: lesson.difficulty,
        notes: lesson.notes,
        audioUrl: lesson.audioUrl,
        videoUrl: lesson.videoUrl,
      )).toList(),
    );
  }

  // Convert CourseLevel to Course
  course_model.Course _convertToModelCourse(CourseLevel courseLevel) {
    return course_model.Course(
      id: courseLevel.id,
      name: courseLevel.name,
      title: courseLevel.name,
      description: courseLevel.description,
      language: courseLevel.language,
      level: courseLevel.level.toString(),
      userId: 'system',
      createdAt: DateTime.now(),
      lessons: courseLevel.lessons.map((lesson) => Lesson(
        id: lesson.id,
        title: lesson.title,
        description: lesson.description,
        vocabulary: lesson.vocabulary.map((word) => VocabItem(
          word: word.word,
          translation: '',
          pronunciation: '',
        )).toList(),
        dialogue: '',
        grammarPoints: lesson.grammarPoints,
        exercises: lesson.exercises.map((ex) => Exercise(
          id: ex.id,
          type: ex.type,
          question: ex.question,
          options: ex.options,
          correctAnswer: ex.correctAnswer,
          explanation: ex.explanation,
          answer: ex.answer ?? ex.correctAnswer,
        )).toList(),
        duration: lesson.duration,
        difficulty: lesson.difficulty,
        notes: lesson.notes,
        audioUrl: lesson.audioUrl,
        videoUrl: lesson.videoUrl,
      )).toList(),
    );
  }

  Future<course_model.Course> _generateCourseContent(
    String language,
    String level,
    String userId,
  ) async {
    try {
      AppLogger.info('Generating course content for $language at $level level');
      
      // Create a unique ID for the course
      final courseId = _uuid.v4();
      
      // Create a basic course structure
      final course = course_model.Course(
        id: courseId,
        name: '$level ${language.capitalize()} Course',
        title: '$level ${language.capitalize()} Course',
        description: 'A personalized $level course for learning ${language.capitalize()}',
        language: language.toLowerCase(),
        level: level.toLowerCase(),
        userId: userId,
        createdAt: DateTime.now(),
        lessons: [
          course_model.Lesson(
            id: _uuid.v4(),
            title: 'Introduction to ${language.capitalize()}',
            description: 'Get started with basic concepts',
            vocabulary: [
              course_model.VocabItem(
                word: 'Hello',
                translation: 'Basic greeting',
                pronunciation: 'hello',
              ),
            ],
            dialogue: 'A: Hello!\nB: Hi, how are you?',
            grammarPoints: ['Basic greetings', 'Simple present tense'],
            exercises: [
              course_model.Exercise(
                id: _uuid.v4(),
                type: 'multiple_choice',
                question: 'How do you say "Hello"?',
                options: ['Hi', 'Goodbye', 'Thank you', 'Please'],
                correctAnswer: 'Hi',
                explanation: 'Hi is another way to say Hello',
                answer: 'Hi',
              ),
            ],
          ),
        ],
      );

      AppLogger.info('Generated course with ID: ${course.id}');
      return course;
    } catch (e, stackTrace) {
      AppLogger.error('Error generating course content', e, stackTrace);
      rethrow;
    }
  }
}
