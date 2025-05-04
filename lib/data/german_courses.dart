import '../models/language_course.dart';

final List<LanguageCourse> germanCourses = [
  LanguageCourse(
    id: 'german_beginner',
    title: 'German for Beginners',
    description:
        'Start your journey to learn German with basic vocabulary and grammar.',
    level: 'Beginner',
    lessons: [
      CourseLesson(
        id: 'german_beginner_1',
        title: 'Greetings and Introductions',
        description:
            'Learn basic German greetings and how to introduce yourself.',
        vocabulary: [
          'Hallo',
          'Guten Tag',
          'Wie geht es Ihnen?',
          'Ich heiße',
          'Freut mich',
          'Auf Wiedersehen',
          'Bis bald',
          'Danke',
          'Bitte',
          'Entschuldigung',
        ],
        grammarPoints: [
          'Basic sentence structure',
          'Personal pronouns (ich, du, Sie)',
          'Formal vs informal greetings',
          'Basic questions and answers',
        ],
        exercises: [
          'Practice introducing yourself',
          'Role-play common greetings',
          'Write a short self-introduction',
        ],
        notes: '''
          - "Guten Tag" is formal
          - "Hallo" is informal
          - "Wie geht es Ihnen?" is formal
          - "Wie geht's?" is informal
        ''',
        audioUrl: 'assets/audio/german/beginner/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example1',
      ),
      CourseLesson(
        id: 'german_beginner_2',
        title: 'Numbers and Time',
        description: 'Learn to count and tell time in German.',
        vocabulary: [
          'Eins',
          'Zwei',
          'Drei',
          'Vier',
          'Fünf',
          'Sechs',
          'Sieben',
          'Acht',
          'Neun',
          'Zehn',
          'Wie spät ist es?',
          'Morgen',
          'Nachmittag',
          'Abend',
          'Mitternacht',
        ],
        grammarPoints: [
          'Cardinal numbers 1-100',
          'Telling time',
          'Days of the week',
          'Months of the year',
        ],
        exercises: [
          'Practice counting to 100',
          'Write the time in German',
          'Create a weekly schedule',
        ],
        notes: '''
          - German uses 24-hour clock
          - "Viertel nach" for quarter past
          - "Halb" for half past
          - "Viertel vor" for quarter to
        ''',
        audioUrl: 'assets/audio/german/beginner/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example2',
      ),
      CourseLesson(
        id: 'german_beginner_3',
        title: 'Daily Activities',
        description: 'Learn vocabulary and phrases for daily routines.',
        vocabulary: [
          'Aufwachen',
          'Aufstehen',
          'Duschen',
          'Frühstücken',
          'Zur Arbeit gehen',
          'Mittagessen',
          'Abendessen',
          'Ins Bett gehen',
          'Schlafen',
          'Arbeiten',
        ],
        grammarPoints: [
          'Reflexive verbs',
          'Present tense conjugation',
          'Time expressions',
          'Adverbs of frequency',
        ],
        exercises: [
          'Describe your daily routine',
          'Create a daily schedule',
          'Interview a partner about their routine',
        ],
        notes: '''
          - Reflexive verbs use "sich"
          - Common time expressions: morgens, nachmittags, abends
          - Adverbs: immer, oft, manchmal, selten, nie
        ''',
        audioUrl: 'assets/audio/german/beginner/lesson3.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example3',
      ),
      CourseLesson(
        id: 'german_beginner_4',
        title: 'Food and Drinks',
        description:
            'Learn vocabulary for food, drinks, and ordering in restaurants.',
        vocabulary: [
          'Brot',
          'Käse',
          'Wein',
          'Wasser',
          'Kaffee',
          'Tee',
          'Obst',
          'Gemüse',
          'Fleisch',
          'Fisch',
          'Ich möchte',
          'Die Rechnung',
          'Speisekarte',
          'Kellner/Kellnerin',
        ],
        grammarPoints: [
          'Articles (der, die, das)',
          'Ordering food',
          'Expressing preferences',
          'Asking for the bill',
        ],
        exercises: [
          'Create a shopping list',
          'Role-play ordering in a restaurant',
          'Describe your favorite meal',
        ],
        notes: '''
          - Use "Ich möchte" to order
          - "Die Rechnung, bitte" to ask for the bill
          - German has three genders for nouns
        ''',
        audioUrl: 'assets/audio/german/beginner/lesson4.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example4',
      ),
    ],
    imageUrl: 'assets/images/german_beginner.png',
    language: 'German',
  ),
  LanguageCourse(
    id: 'german_intermediate',
    title: 'Intermediate German',
    description:
        'Build on your German foundation with more complex grammar and vocabulary.',
    level: 'Intermediate',
    lessons: [
      CourseLesson(
        id: 'german_intermediate_1',
        title: 'Past Tenses',
        description:
            'Learn to talk about past events using different past tenses.',
        vocabulary: [
          'Gestern',
          'Letzte Woche',
          'Letztes Jahr',
          'Schon',
          'Noch',
          'Nie',
          'Immer',
          'Oft',
        ],
        grammarPoints: [
          'Perfekt',
          'Präteritum',
          'Plusquamperfekt',
          'Time expressions',
        ],
        exercises: [
          'Write about your last vacation',
          'Describe a childhood memory',
          'Compare past and present habits',
        ],
        notes: '''
          - Perfekt is most common in spoken German
          - Präteritum is used in written German
          - Plusquamperfekt for actions before other past actions
        ''',
        audioUrl: 'assets/audio/german/intermediate/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example5',
      ),
      CourseLesson(
        id: 'german_intermediate_2',
        title: 'Future and Conditional',
        description:
            'Learn to express future plans and hypothetical situations.',
        vocabulary: [
          'Morgen',
          'Nächste Woche',
          'Nächstes Jahr',
          'Bald',
          'Später',
          'Wenn',
          'Falls',
          'Sobald',
        ],
        grammarPoints: [
          'Future tense',
          'Conditional mood',
          'Wenn clauses',
          'Future perfect',
        ],
        exercises: [
          'Make future plans',
          'Discuss hypothetical situations',
          'Write about future goals',
        ],
        notes: '''
          - Future tense is often replaced by present tense
          - Conditional for polite requests
          - Wenn clauses express conditions
        ''',
        audioUrl: 'assets/audio/german/intermediate/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example6',
      ),
    ],
    imageUrl: 'assets/images/german_intermediate.png',
    language: 'German',
  ),
  LanguageCourse(
    id: 'german_advanced',
    title: 'Advanced German',
    description:
        'Master complex grammar structures and expand your vocabulary.',
    level: 'Advanced',
    lessons: [
      CourseLesson(
        id: 'german_advanced_1',
        title: 'Subjunctive Mood',
        description: 'Learn to use the subjunctive mood in various contexts.',
        vocabulary: [
          'Obwohl',
          'Damit',
          'Um...zu',
          'Bevor',
          'Bis',
          'Ohne dass',
          'Es sei denn',
          'Aus Angst',
        ],
        grammarPoints: [
          'Konjunktiv I',
          'Konjunktiv II',
          'Subjunctive triggers',
          'Complex sentence structures',
        ],
        exercises: [
          'Write persuasive arguments',
          'Express emotions and doubts',
          'Create complex sentences',
        ],
        notes: '''
          - Konjunktiv I for indirect speech
          - Konjunktiv II for hypothetical situations
          - Used after certain conjunctions
        ''',
        audioUrl: 'assets/audio/german/advanced/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example7',
      ),
      CourseLesson(
        id: 'german_advanced_2',
        title: 'Business German',
        description: 'Learn professional communication skills in German.',
        vocabulary: [
          'Unternehmen',
          'Besprechung',
          'Präsentation',
          'Verhandlung',
          'Vertrag',
          'Budget',
          'Kunde',
          'Lieferant',
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
        audioUrl: 'assets/audio/german/advanced/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example8',
      ),
    ],
    imageUrl: 'assets/images/german_advanced.png',
    language: 'German',
  ),
];
