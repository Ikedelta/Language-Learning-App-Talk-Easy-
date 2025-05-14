import '../models/course_model.dart' as course_model;
import '../models/model_types.dart' as level_model;
import '../models/model_types.dart' show Lesson, Exercise, VocabItem;

class ModelConverters {
  static course_model.Course convertToModelCourse(level_model.CourseLevel courseLevel) {
    return course_model.Course(
      id: courseLevel.id,
      name: courseLevel.name,
      title: courseLevel.name,
      description: courseLevel.description,
      language: courseLevel.language,
      level: courseLevel.level.toString(),
      userId: 'system',
      createdAt: DateTime.now(),
      lessons: courseLevel.lessons.map((lesson) => course_model.Lesson(
        id: lesson.id,
        title: lesson.title,
        description: lesson.description,
        vocabulary: lesson.vocabulary.map((word) => course_model.VocabItem(
          word: word.word,
          translation: '', // You might want to fetch translations from a service
          pronunciation: '', // You might want to fetch pronunciations from a service
        )).toList(),
        dialogue: '',
        grammarPoints: lesson.grammarPoints,
        exercises: lesson.exercises.map((ex) => course_model.Exercise(
          id: ex.id,
          type: ex.type,
          question: ex.question,
          options: ex.options,
          correctAnswer: ex.correctAnswer,
          explanation: ex.explanation,
          answer: ex.correctAnswer,
        )).toList(),
        duration: lesson.duration,
        difficulty: lesson.difficulty,
        notes: lesson.notes,
        audioUrl: lesson.audioUrl,
        videoUrl: lesson.videoUrl,
      )).toList(),
    );
  }

  static level_model.CourseLevel convertToCourseLevel(course_model.Course course, int levelNumber) {
    return level_model.CourseLevel(
      id: course.id,
      name: course.name,
      description: course.description,
      level: levelNumber,
      language: course.language,
      imageUrl: 'assets/images/${course.level.toLowerCase()}_${course.language.toLowerCase()}.png',
      isLocked: false,
      requiredXp: levelNumber == 1 ? 0 : (levelNumber - 1) * 100,
      lessons: course.lessons.map((lesson) => level_model.Lesson(
        id: lesson.id,
        title: lesson.title,
        description: lesson.description,
        vocabulary: lesson.vocabulary,
        dialogue: '',
        grammarPoints: lesson.grammarPoints,
        exercises: lesson.exercises.map((ex) => level_model.Exercise(
          id: ex.id,
          type: ex.type,
          question: ex.question,
          options: ex.options,
          correctAnswer: ex.correctAnswer,
          explanation: ex.explanation,
          answer: ex.correctAnswer,
        )).toList(),
        duration: lesson.duration,
        difficulty: lesson.difficulty,
        notes: lesson.notes,
        audioUrl: lesson.audioUrl,
        videoUrl: lesson.videoUrl,
      )).toList(),
    );
  }

  static int getLevelNumber(String levelStr) {
    switch (levelStr.toLowerCase()) {
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
} 