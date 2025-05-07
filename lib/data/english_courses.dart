import '../models/course_level.dart';

final List<CourseLevel> englishCourses = [
  CourseLevel(
    id: 'english_beginner',
    name: 'English for Beginners',
    description:
        'Start your English learning journey with basic vocabulary and grammar.',
    level: 1,
    language: 'english',
    imageUrl: 'assets/images/english_beginner.jpg',
    isLocked: false,
    requiredXp: 0,
    lessons: [
      Lesson(
          id: 'lesson_1_1',
          title: 'Greetings and Introductions',
          description:
              'Learn how to greet people and introduce yourself in English.',
          vocabulary: [
            'Hello',
            'Hi',
            'Good morning',
            'Good afternoon',
            'Good evening',
            'How are you?',
            'I\'m fine, thank you',
            'Nice to meet you',
            'My name is...',
            'What\'s your name?',
            'Where are you from?',
            'I\'m from...',
            'Pleased to meet you',
            'See you later'
          ],
          grammarPoints: [
            'Basic sentence structure',
            'Subject pronouns (I, you, he, she, it, we, they)',
            'Present simple tense',
            'Question formation',
            'Possessive adjectives'
          ],
          exercises: [
            Exercise(
                id: 'ex_1_1_1',
                type: 'multiple_choice',
                question: 'Which greeting is most appropriate for morning?',
                options: ['Good morning', 'Good evening', 'Good night'],
                correctAnswer: 'Good morning',
                explanation:
                    'Good morning is used specifically for morning greetings.'),
            Exercise(
                id: 'ex_1_1_2',
                type: 'fill_blank',
                question: 'Complete the sentence: "___ to meet you."',
                options: ['Nice', 'Good', 'Happy'],
                correctAnswer: 'Nice',
                explanation: 'The correct phrase is "Nice to meet you."'),
            Exercise(
                id: 'ex_1_1_3',
                type: 'translation',
                question: 'Translate: "What is your name?"',
                options: [
                  '¿Cómo te llamas?',
                  'Comment vous appelez-vous?',
                  'Wie heißen Sie?'
                ],
                correctAnswer: '¿Cómo te llamas?',
                explanation:
                    'This is the Spanish translation of "What is your name?"')
          ],
          duration: 30,
          difficulty: 'beginner',
          audioUrl: 'assets/audio/lesson_1_1.mp3',
          videoUrl: 'assets/videos/lesson_1_1.mp4',
          notes:
              'Focus on pronunciation and intonation of greetings. Practice with different time-based greetings.'),
      Lesson(
          id: 'lesson_1_2',
          title: 'Numbers and Colors',
          description: 'Learn to count and name colors in English.',
          vocabulary: [
            'Numbers 1-20',
            'Red',
            'Blue',
            'Green',
            'Yellow',
            'Black',
            'White',
            'Orange',
            'Purple',
            'Pink',
            'Brown',
            'Gray',
            'Gold',
            'Silver',
            'Light',
            'Dark',
            'Bright',
            'Dull'
          ],
          grammarPoints: [
            'Plural forms',
            'This/These',
            'That/Those',
            'Adjective order',
            'Countable and uncountable nouns'
          ],
          exercises: [
            Exercise(
                id: 'ex_1_2_1',
                type: 'multiple_choice',
                question: 'What is the plural form of "book"?',
                options: ['books', 'bookes', 'bookies'],
                correctAnswer: 'books',
                explanation: 'Most nouns form their plural by adding -s.'),
            Exercise(
                id: 'ex_1_2_2',
                type: 'fill_blank',
                question: 'Complete: "___ are my favorite colors."',
                options: ['These', 'This', 'That'],
                correctAnswer: 'These',
                explanation: 'Use "These" for plural nouns.'),
            Exercise(
                id: 'ex_1_2_3',
                type: 'multiple_choice',
                question: 'Which color is a primary color?',
                options: ['Red', 'Purple', 'Orange'],
                correctAnswer: 'Red',
                explanation: 'Red is one of the three primary colors.')
          ],
          duration: 30,
          difficulty: 'beginner',
          audioUrl: 'assets/audio/lesson_1_2.mp3',
          videoUrl: 'assets/videos/lesson_1_2.mp4',
          notes:
              'Pay attention to the pronunciation of numbers. Practice counting objects and describing colors.'),
      Lesson(
          id: 'lesson_1_3',
          title: 'Family and Relationships',
          description:
              'Learn vocabulary and expressions related to family members and relationships.',
          vocabulary: [
            'Mother',
            'Father',
            'Sister',
            'Brother',
            'Grandmother',
            'Grandfather',
            'Aunt',
            'Uncle',
            'Cousin',
            'Niece',
            'Nephew',
            'Sibling',
            'Parent',
            'Child',
            'Spouse',
            'Husband',
            'Wife'
          ],
          grammarPoints: [
            'Possessive \'s',
            'Family relationships',
            'Present simple for habits',
            'Adjectives for describing people',
            'Possessive pronouns'
          ],
          exercises: [
            Exercise(
                id: 'ex_1_3_1',
                type: 'multiple_choice',
                question: 'What is the correct possessive form of "mother"?',
                options: ['mother\'s', 'mothers\'', 'mothers'],
                correctAnswer: 'mother\'s',
                explanation: 'Use \'s for singular possessive.'),
            Exercise(
                id: 'ex_1_3_2',
                type: 'fill_blank',
                question: 'Complete: "My sister\'s husband is my ___."',
                options: ['brother-in-law', 'brother in law', 'brother\'s law'],
                correctAnswer: 'brother-in-law',
                explanation:
                    'The correct term for your sister\'s husband is "brother-in-law".')
          ],
          duration: 30,
          difficulty: 'beginner',
          audioUrl: 'assets/audio/lesson_1_3.mp3',
          videoUrl: 'assets/videos/lesson_1_3.mp4',
          notes:
              'Practice describing your family members and their relationships.')
    ],
  ),
  CourseLevel(
    id: 'english_intermediate',
    name: 'Intermediate English',
    description:
        'Build on your foundation with more complex grammar and vocabulary.',
    level: 2,
    language: 'english',
    imageUrl: 'assets/images/english_intermediate.jpg',
    isLocked: true,
    requiredXp: 70,
    lessons: [
      Lesson(
          id: 'lesson_2_1',
          title: 'Past Tense and Time Expressions',
          description:
              'Learn to talk about past events and use time expressions correctly.',
          vocabulary: [
            'Yesterday',
            'Last week',
            'Last month',
            'Last year',
            'Ago',
            'Before',
            'After',
            'During',
            'While',
            'When',
            'Until',
            'Since',
            'For',
            'In the past',
            'Previously',
            'Formerly'
          ],
          grammarPoints: [
            'Past simple tense',
            'Past continuous tense',
            'Time expressions with past tense',
            'Past perfect tense',
            'Past perfect continuous'
          ],
          exercises: [
            Exercise(
                id: 'ex_2_1_1',
                type: 'multiple_choice',
                question: 'Which is the correct past tense of "go"?',
                options: ['went', 'goed', 'gone'],
                correctAnswer: 'went',
                explanation:
                    'Go is an irregular verb, and its past tense is "went".'),
            Exercise(
                id: 'ex_2_1_2',
                type: 'fill_blank',
                question: 'Complete: "I ___ studying when you called."',
                options: ['was', 'were', 'am'],
                correctAnswer: 'was',
                explanation:
                    'Use "was" with singular subjects in past continuous.'),
            Exercise(
                id: 'ex_2_1_3',
                type: 'multiple_choice',
                question:
                    'Which tense is used for actions that happened before another past action?',
                options: ['Past perfect', 'Past simple', 'Past continuous'],
                correctAnswer: 'Past perfect',
                explanation:
                    'Past perfect is used for actions that happened before another past action.')
          ],
          duration: 45,
          difficulty: 'intermediate',
          audioUrl: 'assets/audio/lesson_2_1.mp3',
          videoUrl: 'assets/videos/lesson_2_1.mp4',
          notes:
              'Focus on irregular past tense verbs and the correct use of time expressions.'),
      Lesson(
          id: 'lesson_2_2',
          title: 'Future Plans and Predictions',
          description: 'Learn to express future plans and make predictions.',
          vocabulary: [
            'Will',
            'Going to',
            'Plan to',
            'Intend to',
            'Hope to',
            'Expect to',
            'Predict',
            'Forecast',
            'Anticipate',
            'Schedule',
            'Arrange',
            'Book',
            'Reserve',
            'Prepare for'
          ],
          grammarPoints: [
            'Future simple tense',
            'Going to future',
            'Present continuous for future',
            'Future perfect',
            'Future continuous'
          ],
          exercises: [
            Exercise(
                id: 'ex_2_2_1',
                type: 'multiple_choice',
                question: 'Which form is used for planned future actions?',
                options: ['going to', 'will', 'present simple'],
                correctAnswer: 'going to',
                explanation:
                    '\'Going to\' is used for planned future actions.'),
            Exercise(
                id: 'ex_2_2_2',
                type: 'fill_blank',
                question: 'Complete: "By next year, I ___ my degree."',
                options: [
                  'will have completed',
                  'will complete',
                  'am completing'
                ],
                correctAnswer: 'will have completed',
                explanation:
                    'Use future perfect for actions that will be completed by a specific time in the future.')
          ],
          duration: 45,
          difficulty: 'intermediate',
          audioUrl: 'assets/audio/lesson_2_2.mp3',
          videoUrl: 'assets/videos/lesson_2_2.mp4',
          notes: 'Practice making predictions and discussing future plans.'),
      Lesson(
          id: 'lesson_2_3',
          title: 'Modal Verbs and Possibility',
          description:
              'Learn to express possibility, ability, and necessity using modal verbs.',
          vocabulary: [
            'Can',
            'Could',
            'May',
            'Might',
            'Must',
            'Should',
            'Would',
            'Ought to',
            'Have to',
            'Need to',
            'Possible',
            'Impossible',
            'Necessary',
            'Optional',
            'Required'
          ],
          grammarPoints: [
            'Modal verbs for possibility',
            'Modal verbs for ability',
            'Modal verbs for necessity',
            'Modal verbs for advice',
            'Modal verbs for permission'
          ],
          exercises: [
            Exercise(
                id: 'ex_2_3_1',
                type: 'multiple_choice',
                question: 'Which modal verb expresses strong necessity?',
                options: ['must', 'might', 'could'],
                correctAnswer: 'must',
                explanation:
                    '\'Must\' expresses strong necessity or obligation.'),
            Exercise(
                id: 'ex_2_3_2',
                type: 'fill_blank',
                question: 'Complete: "You ___ study for the exam."',
                options: ['should', 'can', 'may'],
                correctAnswer: 'should',
                explanation: '\'Should\' is used for advice or recommendation.')
          ],
          duration: 45,
          difficulty: 'intermediate',
          audioUrl: 'assets/audio/lesson_2_3.mp3',
          videoUrl: 'assets/videos/lesson_2_3.mp4',
          notes:
              'Practice using modal verbs in different contexts and situations.')
    ],
  ),
  CourseLevel(
    id: 'english_advanced',
    name: 'Advanced English',
    description:
        'Master complex grammar structures and expand your vocabulary.',
    level: 3,
    language: 'english',
    imageUrl: 'assets/images/english_advanced.jpg',
    isLocked: true,
    requiredXp: 85,
    lessons: [
      Lesson(
          id: 'lesson_3_1',
          title: 'Conditionals and Hypothetical Situations',
          description:
              'Learn to express hypothetical situations and conditions.',
          vocabulary: [
            'If',
            'Unless',
            'Provided that',
            'In case',
            'As long as',
            'Supposing',
            'Assuming',
            'Given that',
            'On condition that',
            'Hypothetical',
            'Conditional',
            'Consequence',
            'Outcome'
          ],
          grammarPoints: [
            'Zero conditional',
            'First conditional',
            'Second conditional',
            'Third conditional',
            'Mixed conditionals'
          ],
          exercises: [
            Exercise(
                id: 'ex_3_1_1',
                type: 'multiple_choice',
                question:
                    'Which conditional is used for hypothetical situations?',
                options: [
                  'Second conditional',
                  'First conditional',
                  'Zero conditional'
                ],
                correctAnswer: 'Second conditional',
                explanation:
                    'Second conditional is used for hypothetical or unlikely situations.'),
            Exercise(
                id: 'ex_3_1_2',
                type: 'fill_blank',
                question:
                    'Complete: "If I ___ rich, I would travel the world."',
                options: ['were', 'was', 'am'],
                correctAnswer: 'were',
                explanation:
                    'In second conditional, use "were" for all subjects.'),
            Exercise(
                id: 'ex_3_1_3',
                type: 'multiple_choice',
                question:
                    'Which conditional is used for past hypothetical situations?',
                options: [
                  'Third conditional',
                  'Second conditional',
                  'First conditional'
                ],
                correctAnswer: 'Third conditional',
                explanation:
                    'Third conditional is used for past hypothetical situations.')
          ],
          duration: 60,
          difficulty: 'advanced',
          audioUrl: 'assets/audio/lesson_3_1.mp3',
          videoUrl: 'assets/videos/lesson_3_1.mp4',
          notes:
              'Focus on the differences between conditional types and their appropriate usage.'),
      Lesson(
          id: 'lesson_3_2',
          title: 'Academic Writing and Formal Language',
          description:
              'Develop skills for academic writing and formal communication.',
          vocabulary: [
            'Furthermore',
            'Moreover',
            'Nevertheless',
            'Consequently',
            'In conclusion',
            'To summarize',
            'In addition',
            'However',
            'Therefore',
            'Thus',
            'Hence',
            'Accordingly'
          ],
          grammarPoints: [
            'Passive voice',
            'Reported speech',
            'Complex sentence structures',
            'Academic vocabulary',
            'Formal expressions'
          ],
          exercises: [
            Exercise(
                id: 'ex_3_2_1',
                type: 'multiple_choice',
                question:
                    'Which is the correct passive form of "The team completed the project"?',
                options: [
                  'The project was completed by the team',
                  'The project is completed by the team',
                  'The project has been completed by the team'
                ],
                correctAnswer: 'The project was completed by the team',
                explanation:
                    'Use past simple passive for completed actions in the past.'),
            Exercise(
                id: 'ex_3_2_2',
                type: 'fill_blank',
                question:
                    'Complete: "The research ___ that climate change is accelerating."',
                options: ['indicates', 'indicated', 'has indicated'],
                correctAnswer: 'indicates',
                explanation:
                    'Use present simple for general truths in academic writing.')
          ],
          duration: 60,
          difficulty: 'advanced',
          audioUrl: 'assets/audio/lesson_3_2.mp3',
          videoUrl: 'assets/videos/lesson_3_2.mp4',
          notes:
              'Practice using formal language and academic writing conventions.'),
      Lesson(
          id: 'lesson_3_3',
          title: 'Idiomatic Expressions and Phrasal Verbs',
          description:
              'Master common idioms and phrasal verbs for natural English communication.',
          vocabulary: [
            'Break a leg',
            'Piece of cake',
            'Hit the road',
            'Get over',
            'Look forward to',
            'Put up with',
            'Come across',
            'Run into',
            'Figure out',
            'Work out',
            'Give up',
            'Take up'
          ],
          grammarPoints: [
            'Idiomatic usage',
            'Phrasal verb patterns',
            'Context clues',
            'Collocations',
            'Register and tone'
          ],
          exercises: [
            Exercise(
                id: 'ex_3_3_1',
                type: 'multiple_choice',
                question: 'What does "break a leg" mean?',
                options: ['Good luck', 'Bad luck', 'Get injured'],
                correctAnswer: 'Good luck',
                explanation: '\'Break a leg\' is an idiom meaning good luck.'),
            Exercise(
                id: 'ex_3_3_2',
                type: 'fill_blank',
                question: 'Complete: "I need to ___ this problem."',
                options: ['figure out', 'figure in', 'figure up'],
                correctAnswer: 'figure out',
                explanation:
                    '\'Figure out\' means to solve or understand something.')
          ],
          duration: 60,
          difficulty: 'advanced',
          audioUrl: 'assets/audio/lesson_3_3.mp3',
          videoUrl: 'assets/videos/lesson_3_3.mp4',
          notes: 'Practice using idioms and phrasal verbs in context.')
    ],
  )
];
