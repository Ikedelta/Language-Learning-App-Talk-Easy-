import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/language_course.dart';
import 'package:easy_talk/models/course_level.dart';
import 'package:uuid/uuid.dart';
import '../data/english_courses.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  // Initialize courses in Firestore
  Future<void> initializeCourses() async {
    try {
      // Check if courses already exist
      final coursesSnapshot = await _firestore.collection('courses').get();
      if (coursesSnapshot.docs.isNotEmpty) {
        return; // Courses already initialized
      }

      // Add English courses
      for (final course in englishCourses) {
        await _firestore
            .collection('courses')
            .doc(course.id)
            .set(course.toJson());
      }
    } catch (e) {
      print('Error initializing courses: $e');
      rethrow;
    }
  }

  Stream<List<CourseLevel>> getCoursesByLanguage(String language) {
    try {
      return _firestore
          .collection('courses')
          .where('language', isEqualTo: language.toLowerCase())
          .orderBy('level')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();

          // Handle both CourseLevel and LanguageCourse data structures
          final level = data['level'];
          final int levelNumber = level is int
              ? level
              : level is String
                  ? _getLevelNumber(level)
                  : 1;

          return CourseLevel(
            id: doc.id,
            name: data['title'] ?? data['name'] ?? '',
            description: data['description'] ?? '',
            level: levelNumber,
            language: data['language'] ?? '',
            imageUrl: data['imageUrl'] ?? '',
            isLocked: data['isLocked'] ?? true,
            requiredXp: data['requiredXp'] ?? 0,
            lessons: (data['lessons'] as List?)?.map((lesson) {
                  return Lesson(
                    id: lesson['id'] ?? '',
                    title: lesson['title'] ?? '',
                    description: lesson['description'] ?? '',
                    vocabulary: List<String>.from(lesson['vocabulary'] ?? []),
                    grammarPoints:
                        List<String>.from(lesson['grammarPoints'] ?? []),
                    exercises: (lesson['exercises'] as List?)?.map((exercise) {
                          if (exercise is String) {
                            return Exercise(
                              id: const Uuid().v4(),
                              type: 'text',
                              question: exercise,
                              options: [],
                              correctAnswer: '',
                              explanation: '',
                            );
                          }
                          return Exercise(
                            id: exercise['id'] ?? '',
                            type: exercise['type'] ?? '',
                            question: exercise['question'] ?? '',
                            options:
                                List<String>.from(exercise['options'] ?? []),
                            correctAnswer: exercise['correctAnswer'] ?? '',
                            explanation: exercise['explanation'] ?? '',
                          );
                        }).toList() ??
                        [],
                    duration: lesson['duration'] ?? 30,
                    difficulty: lesson['difficulty'] ?? 'beginner',
                    audioUrl: lesson['audioUrl'] ?? '',
                    videoUrl: lesson['videoUrl'] ?? '',
                    notes: lesson['notes'] ?? '',
                  );
                }).toList() ??
                [],
          );
        }).toList();
      });
    } catch (e) {
      print('Error in getCoursesByLanguage: $e');
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
                  vocabulary: List<String>.from(lesson['vocabulary'] ?? []),
                  grammarPoints:
                      List<String>.from(lesson['grammarPoints'] ?? []),
                  exercises: (lesson['exercises'] as List?)?.map((exercise) {
                        if (exercise is String) {
                          return Exercise(
                            id: const Uuid().v4(),
                            type: 'text',
                            question: exercise,
                            options: [],
                            correctAnswer: '',
                            explanation: '',
                          );
                        }
                        return Exercise(
                          id: exercise['id'] ?? '',
                          type: exercise['type'] ?? '',
                          question: exercise['question'] ?? '',
                          options: List<String>.from(exercise['options'] ?? []),
                          correctAnswer: exercise['correctAnswer'] ?? '',
                          explanation: exercise['explanation'] ?? '',
                        );
                      }).toList() ??
                      [],
                  difficulty: lesson['difficulty'] ?? 'beginner',
                  audioUrl: lesson['audioUrl'] ?? '',
                  videoUrl: lesson['videoUrl'] ?? '',
                  notes: lesson['notes'] ?? '',
                  duration: lesson['duration'] ?? 30,
                );
              }).toList() ??
              [],
        );
      }).toList();
    } catch (e) {
      print('Error getting course levels: $e');
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
  Future<Lesson?> getLesson(
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
      return Lesson.fromJson(doc.data()!);
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
      final batch = _firestore.batch();

      // Add Beginner Level
      final beginnerLevel = CourseLevel(
        id: _uuid.v4(),
        name: 'Beginner',
        description: 'Start your journey with basic vocabulary and grammar',
        level: 1,
        language: language,
        imageUrl: 'assets/images/beginner_$language.png',
        isLocked: false,
        lessons: [
          Lesson(
            id: _uuid.v4(),
            title: 'Greetings and Introductions',
            description: 'Learn how to greet people and introduce yourself',
            vocabulary: ['Hello', 'Goodbye', 'Thank you', 'Please'],
            grammarPoints: ['Basic sentence structure', 'Present tense'],
            exercises: [
              Exercise(
                id: _uuid.v4(),
                type: 'multiple_choice',
                question: 'How do you say "Hello" in $language?',
                options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
                correctAnswer: 'Option 1',
                explanation: 'The correct way to say hello is...',
              ),
            ],
            duration: 30,
            difficulty: 'Beginner',
          ),
        ],
      );

      // Add Intermediate Level
      final intermediateLevel = CourseLevel(
        id: _uuid.v4(),
        name: 'Intermediate',
        description: 'Build on your foundation with more complex topics',
        level: 2,
        language: language,
        imageUrl: 'assets/images/intermediate_$language.png',
        requiredXp: 100,
        lessons: [
          Lesson(
            id: _uuid.v4(),
            title: 'Past Tense',
            description: 'Learn how to talk about past events',
            vocabulary: ['Yesterday', 'Last week', 'Before', 'After'],
            grammarPoints: ['Past tense conjugation', 'Time expressions'],
            exercises: [
              Exercise(
                id: _uuid.v4(),
                type: 'fill_blank',
                question:
                    'Complete the sentence: "I ___ to the store yesterday."',
                options: ['went', 'go', 'going', 'gone'],
                correctAnswer: 'went',
                explanation: 'The past tense of "go" is "went"',
              ),
            ],
            duration: 45,
            difficulty: 'Intermediate',
          ),
        ],
      );

      // Add Advanced Level
      final advancedLevel = CourseLevel(
        id: _uuid.v4(),
        name: 'Advanced',
        description: 'Master complex grammar and idiomatic expressions',
        level: 3,
        language: language,
        imageUrl: 'assets/images/advanced_$language.png',
        requiredXp: 300,
        lessons: [
          Lesson(
            id: _uuid.v4(),
            title: 'Idiomatic Expressions',
            description: 'Learn common idioms and their usage',
            vocabulary: ['Break a leg', 'Piece of cake', 'Hit the road'],
            grammarPoints: ['Idiomatic usage', 'Context clues'],
            exercises: [
              Exercise(
                id: _uuid.v4(),
                type: 'translation',
                question: 'Translate: "It\'s raining cats and dogs"',
                options: ['Literal translation', 'Idiomatic translation'],
                correctAnswer: 'Idiomatic translation',
                explanation: 'This idiom means it\'s raining heavily',
              ),
            ],
            duration: 60,
            difficulty: 'Advanced',
          ),
        ],
      );

      // Add levels to Firestore
      final levels = [beginnerLevel, intermediateLevel, advancedLevel];
      for (var level in levels) {
        final levelRef = _firestore
            .collection('courses')
            .doc(language.toLowerCase())
            .collection('levels')
            .doc(level.id);

        batch.set(levelRef, level.toJson());

        // Add lessons
        for (var lesson in level.lessons) {
          final lessonRef = levelRef.collection('lessons').doc(lesson.id);
          batch.set(lessonRef, lesson.toJson());
        }
      }

      await batch.commit();
    } catch (e) {
      print('Error adding sample course content: $e');
      rethrow;
    }
  }
}
