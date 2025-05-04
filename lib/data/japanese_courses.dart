import '../models/language_course.dart';

final List<LanguageCourse> japaneseCourses = [
  LanguageCourse(
    id: 'japanese_beginner',
    title: 'Japanese for Beginners',
    description:
        'Start your journey to learn Japanese with basic vocabulary and grammar.',
    level: 'Beginner',
    lessons: [
      CourseLesson(
        id: 'japanese_beginner_1',
        title: 'Greetings and Introductions',
        description:
            'Learn basic Japanese greetings and how to introduce yourself.',
        vocabulary: [
          'こんにちは',
          'おはようございます',
          'こんばんは',
          'ありがとう',
          'すみません',
          'はじめまして',
          'わたしは',
          'おげんきですか',
          'さようなら',
          'またね',
        ],
        grammarPoints: [
          'Basic sentence structure',
          'Particles (は, が, を)',
          'Formal vs informal speech',
          'Basic questions and answers',
        ],
        exercises: [
          'Practice introducing yourself',
          'Role-play common greetings',
          'Write a short self-introduction',
        ],
        notes: '''
          - こんにちは is used during the day
          - おはようございます is used in the morning
          - こんばんは is used in the evening
          - はじめまして is used when meeting someone for the first time
        ''',
        audioUrl: 'assets/audio/japanese/beginner/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example1',
      ),
      CourseLesson(
        id: 'japanese_beginner_2',
        title: 'Numbers and Time',
        description: 'Learn to count and tell time in Japanese.',
        vocabulary: [
          'いち',
          'に',
          'さん',
          'よん',
          'ご',
          'ろく',
          'なな',
          'はち',
          'きゅう',
          'じゅう',
          'いまなんじですか',
          'あさ',
          'ひる',
          'よる',
          'まよなか',
        ],
        grammarPoints: [
          'Counting systems (いち, ひとつ)',
          'Telling time',
          'Days of the week',
          'Months of the year',
        ],
        exercises: [
          'Practice counting to 100',
          'Write the time in Japanese',
          'Create a weekly schedule',
        ],
        notes: '''
          - Japanese uses different counting systems
          - Time is expressed in 24-hour format
          - Days of the week end with ようび
        ''',
        audioUrl: 'assets/audio/japanese/beginner/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example2',
      ),
      CourseLesson(
        id: 'japanese_beginner_3',
        title: 'Daily Activities',
        description: 'Learn vocabulary and phrases for daily routines.',
        vocabulary: [
          'おきる',
          'ねる',
          'あさごはん',
          'しごと',
          'ひるごはん',
          'ばんごはん',
          'べんきょう',
          'テレビ',
          'でんわ',
          'かいもの',
        ],
        grammarPoints: [
          'Verb conjugation',
          'Present tense',
          'Time expressions',
          'Frequency adverbs',
        ],
        exercises: [
          'Describe your daily routine',
          'Create a daily schedule',
          'Interview a partner about their routine',
        ],
        notes: '''
          - Verbs come at the end of the sentence
          - Time expressions come at the beginning
          - Frequency adverbs come before the verb
        ''',
        audioUrl: 'assets/audio/japanese/beginner/lesson3.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example3',
      ),
      CourseLesson(
        id: 'japanese_beginner_4',
        title: 'Food and Drinks',
        description:
            'Learn vocabulary for food, drinks, and ordering in restaurants.',
        vocabulary: [
          'ごはん',
          'みず',
          'おちゃ',
          'コーヒー',
          'さかな',
          'にく',
          'やさい',
          'くだもの',
          'メニュー',
          'おかいけい',
        ],
        grammarPoints: [
          'Ordering food',
          'Expressing preferences',
          'Counting objects',
          'Asking for the bill',
        ],
        exercises: [
          'Create a shopping list',
          'Role-play ordering in a restaurant',
          'Describe your favorite meal',
        ],
        notes: '''
          - Use ください to order
          - おかいけいをおねがいします to ask for the bill
          - Different counters for different types of objects
        ''',
        audioUrl: 'assets/audio/japanese/beginner/lesson4.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example4',
      ),
    ],
    imageUrl: 'assets/images/japanese_beginner.png',
    language: 'Japanese',
  ),
  LanguageCourse(
    id: 'japanese_intermediate',
    title: 'Intermediate Japanese',
    description:
        'Build on your Japanese foundation with more complex grammar and vocabulary.',
    level: 'Intermediate',
    lessons: [
      CourseLesson(
        id: 'japanese_intermediate_1',
        title: 'Past Tenses',
        description:
            'Learn to talk about past events using different past tenses.',
        vocabulary: [
          'きのう',
          'せんしゅう',
          'きょねん',
          'もう',
          'まだ',
          'ぜんぜん',
          'いつも',
          'よく',
        ],
        grammarPoints: [
          'Past tense conjugation',
          'て-form',
          'た-form',
          'Time expressions',
        ],
        exercises: [
          'Write about your last vacation',
          'Describe a childhood memory',
          'Compare past and present habits',
        ],
        notes: '''
          - た-form for completed actions
          - て-form for ongoing actions
          - Time expressions come at the beginning
        ''',
        audioUrl: 'assets/audio/japanese/intermediate/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example5',
      ),
      CourseLesson(
        id: 'japanese_intermediate_2',
        title: 'Future and Conditional',
        description:
            'Learn to express future plans and hypothetical situations.',
        vocabulary: [
          'あした',
          'らいしゅう',
          'らいねん',
          'そのうち',
          'あとで',
          'もし',
          'とき',
          'たら',
        ],
        grammarPoints: [
          'Future tense',
          'Conditional forms',
          'と, ば, たら, なら',
          'Future perfect',
        ],
        exercises: [
          'Make future plans',
          'Discuss hypothetical situations',
          'Write about future goals',
        ],
        notes: '''
          - Future tense is often implied
          - Different conditional forms for different situations
          - と, ば, たら, なら have different uses
        ''',
        audioUrl: 'assets/audio/japanese/intermediate/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example6',
      ),
    ],
    imageUrl: 'assets/images/japanese_intermediate.png',
    language: 'Japanese',
  ),
  LanguageCourse(
    id: 'japanese_advanced',
    title: 'Advanced Japanese',
    description:
        'Master complex grammar structures and expand your vocabulary.',
    level: 'Advanced',
    lessons: [
      CourseLesson(
        id: 'japanese_advanced_1',
        title: 'Honorific Language',
        description:
            'Learn to use honorific and humble language in various contexts.',
        vocabulary: [
          'いらっしゃる',
          'おっしゃる',
          'なさる',
          'いたす',
          'もうしあげる',
          'いただく',
          'くださる',
          'さしあげる',
        ],
        grammarPoints: [
          'Honorific forms',
          'Humble forms',
          'Polite language',
          'Business Japanese',
        ],
        exercises: [
          'Write formal emails',
          'Practice business conversations',
          'Create formal presentations',
        ],
        notes: '''
          - Different honorific forms for different situations
          - Humble forms show respect
          - Business Japanese requires specific vocabulary
        ''',
        audioUrl: 'assets/audio/japanese/advanced/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example7',
      ),
      CourseLesson(
        id: 'japanese_advanced_2',
        title: 'Business Japanese',
        description: 'Learn professional communication skills in Japanese.',
        vocabulary: [
          'かいしゃ',
          'かいぎ',
          'プレゼン',
          'こうしょう',
          'けいやく',
          'よさん',
          'きゃく',
          'きょうきゅうしゃ',
        ],
        grammarPoints: [
          'Formal business language',
          'Email etiquette',
          'Meeting vocabulary',
          'Professional presentations',
        ],
        exercises: [
          'Write business emails',
          'Prepare a presentation',
          'Role-play business meetings',
        ],
        notes: '''
          - Formal vs informal business language
          - Professional email structure
          - Meeting protocol
        ''',
        audioUrl: 'assets/audio/japanese/advanced/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example8',
      ),
    ],
    imageUrl: 'assets/images/japanese_advanced.png',
    language: 'Japanese',
  ),
];
