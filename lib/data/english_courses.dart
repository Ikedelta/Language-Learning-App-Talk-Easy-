import '../models/course_level.dart';
import '../models/model_types.dart';

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
            VocabItem(
              word: 'Hello',
              translation: 'Hola',
              pronunciation: 'həˈləʊ',
            ),
            VocabItem(
              word: 'Hi',
              translation: 'Hola',
              pronunciation: 'haɪ',
            ),
            VocabItem(
              word: 'Good morning',
              translation: 'Buenos días',
              pronunciation: 'ɡʊd ˈmɔːnɪŋ',
            ),
            VocabItem(
              word: 'Good afternoon',
              translation: 'Buenas tardes',
              pronunciation: 'ɡʊd ˌɑːftəˈnuːn',
            ),
            VocabItem(
              word: 'Good evening',
              translation: 'Buenas noches',
              pronunciation: 'ɡʊd ˈiːvnɪŋ',
            ),
            VocabItem(
              word: 'How are you?',
              translation: '¿Cómo estás?',
              pronunciation: 'haʊ ɑː juː',
            ),
            VocabItem(
              word: 'I\'m fine, thank you',
              translation: 'Estoy bien, gracias',
              pronunciation: 'aɪm faɪn θæŋk juː',
            ),
            VocabItem(
              word: 'Nice to meet you',
              translation: 'Encantado/a de conocerte',
              pronunciation: 'naɪs tuː miːt juː',
            ),
            VocabItem(
              word: 'My name is...',
              translation: 'Mi nombre es...',
              pronunciation: 'maɪ neɪm ɪz',
            ),
            VocabItem(
              word: 'What\'s your name?',
              translation: '¿Cómo te llamas?',
              pronunciation: 'wɒts jɔː neɪm',
            ),
            VocabItem(
              word: 'Where are you from?',
              translation: '¿De dónde eres?',
              pronunciation: 'weər ɑː juː frɒm',
            ),
            VocabItem(
              word: 'I\'m from...',
              translation: 'Soy de...',
              pronunciation: 'aɪm frɒm',
            ),
            VocabItem(
              word: 'Pleased to meet you',
              translation: 'Encantado/a de conocerte',
              pronunciation: 'pliːzd tuː miːt juː',
            ),
            VocabItem(
              word: 'See you later',
              translation: 'Hasta luego',
              pronunciation: 'siː juː ˈleɪtə',
            ),
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
                    'Good morning is used specifically for morning greetings.',
                answer: 'Good morning'),
            Exercise(
                id: 'ex_1_1_2',
                type: 'fill_blank',
                question: 'Complete the sentence: "___ to meet you."',
                options: ['Nice', 'Good', 'Happy'],
                correctAnswer: 'Nice',
                explanation: 'The correct phrase is "Nice to meet you."',
                answer: 'Nice'),
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
                    'This is the Spanish translation of "What is your name?"',
                answer: '¿Cómo te llamas?')
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
            VocabItem(
              word: 'Numbers 1-20',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Red',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Blue',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Green',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Yellow',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Black',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'White',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Orange',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Purple',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Pink',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Brown',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Gray',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Gold',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Silver',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Light',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Dark',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Bright',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Dull',
              translation: '',
              pronunciation: '',
            ),
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
                explanation: 'Most nouns form their plural by adding -s.',
                answer: 'books'),
            Exercise(
                id: 'ex_1_2_2',
                type: 'fill_blank',
                question: 'Complete: "___ are my favorite colors."',
                options: ['These', 'This', 'That'],
                correctAnswer: 'These',
                explanation: 'Use "These" for plural nouns.',
                answer: 'These'),
            Exercise(
                id: 'ex_1_2_3',
                type: 'multiple_choice',
                question: 'Which color is a primary color?',
                options: ['Red', 'Purple', 'Orange'],
                correctAnswer: 'Red',
                explanation: 'Red is one of the three primary colors.',
                answer: 'Red')
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
            VocabItem(
              word: 'Mother',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Father',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Sister',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Brother',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Grandmother',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Grandfather',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Aunt',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Uncle',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Cousin',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Niece',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Nephew',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Sibling',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Parent',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Child',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Spouse',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Husband',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Wife',
              translation: '',
              pronunciation: '',
            ),
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
                explanation: 'Use \'s for singular possessive.',
                answer: 'mother\'s'),
            Exercise(
                id: 'ex_1_3_2',
                type: 'fill_blank',
                question: 'Complete: "My sister\'s husband is my ___."',
                options: ['brother-in-law', 'brother in law', 'brother\'s law'],
                correctAnswer: 'brother-in-law',
                explanation:
                    'The correct term for your sister\'s husband is "brother-in-law".',
                answer: 'brother-in-law')
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
            VocabItem(
              word: 'Yesterday',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Last week',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Last month',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Last year',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Ago',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Before',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'After',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'During',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'While',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'When',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Until',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Since',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'For',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'In the past',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Previously',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Formerly',
              translation: '',
              pronunciation: '',
            ),
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
                    'Go is an irregular verb, and its past tense is "went".',
                answer: 'went'),
            Exercise(
                id: 'ex_2_1_2',
                type: 'fill_blank',
                question: 'Complete: "I ___ studying when you called."',
                options: ['was', 'were', 'am'],
                correctAnswer: 'was',
                explanation:
                    'Use "was" with singular subjects in past continuous.',
                answer: 'was'),
            Exercise(
                id: 'ex_2_1_3',
                type: 'multiple_choice',
                question:
                    'Which tense is used for actions that happened before another past action?',
                options: ['Past perfect', 'Past simple', 'Past continuous'],
                correctAnswer: 'Past perfect',
                explanation:
                    'Past perfect is used for actions that happened before another past action.',
                answer: 'Past perfect')
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
            VocabItem(
              word: 'Will',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Going to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Plan to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Intend to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Hope to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Expect to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Predict',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Forecast',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Anticipate',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Schedule',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Arrange',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Book',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Reserve',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Prepare for',
              translation: '',
              pronunciation: '',
            ),
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
                    '\'Going to\' is used for planned future actions.',
                answer: 'going to'),
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
                    'Use future perfect for actions that will be completed by a specific time in the future.',
                answer: 'will have completed')
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
            VocabItem(
              word: 'Can',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Could',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'May',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Might',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Must',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Should',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Would',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Ought to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Have to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Need to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Possible',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Impossible',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Necessary',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Optional',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Required',
              translation: '',
              pronunciation: '',
            ),
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
                    '\'Must\' expresses strong necessity or obligation.',
                answer: 'must'),
            Exercise(
                id: 'ex_2_3_2',
                type: 'fill_blank',
                question: 'Complete: "You ___ study for the exam."',
                options: ['should', 'can', 'may'],
                correctAnswer: 'should',
                explanation: '\'Should\' is used for advice or recommendation.',
                answer: 'should')
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
            VocabItem(
              word: 'If',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Unless',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Provided that',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'In case',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'As long as',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Supposing',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Assuming',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Given that',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'On condition that',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Hypothetical',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Conditional',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Consequence',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Outcome',
              translation: '',
              pronunciation: '',
            ),
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
                    'Second conditional is used for hypothetical or unlikely situations.',
                answer: 'Second conditional'),
            Exercise(
                id: 'ex_3_1_2',
                type: 'fill_blank',
                question:
                    'Complete: "If I ___ rich, I would travel the world."',
                options: ['were', 'was', 'am'],
                correctAnswer: 'were',
                explanation:
                    'In second conditional, use "were" for all subjects.',
                answer: 'were'),
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
                    'Third conditional is used for past hypothetical situations.',
                answer: 'Third conditional')
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
            VocabItem(
              word: 'Furthermore',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Moreover',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Nevertheless',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Consequently',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'In conclusion',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'To summarize',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'In addition',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'However',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Therefore',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Thus',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Hence',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Accordingly',
              translation: '',
              pronunciation: '',
            ),
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
                    'Use past simple passive for completed actions in the past.',
                answer: 'The project was completed by the team'),
            Exercise(
                id: 'ex_3_2_2',
                type: 'fill_blank',
                question:
                    'Complete: "The research ___ that climate change is accelerating."',
                options: ['indicates', 'indicated', 'has indicated'],
                correctAnswer: 'indicates',
                explanation:
                    'Use present simple for general truths in academic writing.',
                answer: 'indicates')
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
            VocabItem(
              word: 'Break a leg',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Piece of cake',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Hit the road',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Get over',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Look forward to',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Put up with',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Come across',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Run into',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Figure out',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Work out',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Give up',
              translation: '',
              pronunciation: '',
            ),
            VocabItem(
              word: 'Take up',
              translation: '',
              pronunciation: '',
            ),
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
                explanation: '\'Break a leg\' is an idiom meaning good luck.',
                answer: 'Good luck'),
            Exercise(
                id: 'ex_3_3_2',
                type: 'fill_blank',
                question: 'Complete: "I need to ___ this problem."',
                options: ['figure out', 'figure in', 'figure up'],
                correctAnswer: 'figure out',
                explanation:
                    '\'Figure out\' means to solve or understand something.',
                answer: 'figure out')
          ],
          duration: 60,
          difficulty: 'advanced',
          audioUrl: 'assets/audio/lesson_3_3.mp3',
          videoUrl: 'assets/videos/lesson_3_3.mp4',
          notes: 'Practice using idioms and phrasal verbs in context.')
    ],
  )
];
