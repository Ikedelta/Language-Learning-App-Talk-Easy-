import '../models/language_course.dart';

final List<LanguageCourse> frenchCourses = [
  LanguageCourse(
    id: 'french_beginner',
    title: 'French for Beginners',
    description:
        'Start your journey to learn French with basic vocabulary and grammar.',
    level: 'Beginner',
    lessons: [
      CourseLesson(
        id: 'french_beginner_1',
        title: 'Greetings and Introductions',
        description:
            'Learn basic French greetings and how to introduce yourself.',
        vocabulary: [
          'Bonjour',
          'Salut',
          'Comment allez-vous?',
          'Je m\'appelle',
          'Enchanté(e)',
          'Au revoir',
          'À bientôt',
          'Merci',
          'S\'il vous plaît',
          'Excusez-moi',
        ],
        grammarPoints: [
          'Basic sentence structure',
          'Personal pronouns (je, tu, il/elle)',
          'Formal vs informal greetings',
          'Basic questions and answers',
        ],
        exercises: [
          'Practice introducing yourself',
          'Role-play common greetings',
          'Write a short self-introduction',
        ],
        notes: '''
          - "Bonjour" is used during the day
          - "Salut" is informal
          - "Comment allez-vous?" is formal
          - "Comment ça va?" is informal
        ''',
        audioUrl: 'assets/audio/french/beginner/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example1',
      ),
      CourseLesson(
        id: 'french_beginner_2',
        title: 'Numbers and Time',
        description: 'Learn to count and tell time in French.',
        vocabulary: [
          'Un',
          'Deux',
          'Trois',
          'Quatre',
          'Cinq',
          'Six',
          'Sept',
          'Huit',
          'Neuf',
          'Dix',
          'Quelle heure est-il?',
          'Matin',
          'Après-midi',
          'Soir',
          'Minuit',
        ],
        grammarPoints: [
          'Cardinal numbers 1-100',
          'Telling time',
          'Days of the week',
          'Months of the year',
        ],
        exercises: [
          'Practice counting to 100',
          'Write the time in French',
          'Create a weekly schedule',
        ],
        notes: '''
          - French uses 24-hour clock
          - "et quart" for quarter past
          - "et demie" for half past
          - "moins le quart" for quarter to
        ''',
        audioUrl: 'assets/audio/french/beginner/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example2',
      ),
      CourseLesson(
        id: 'french_beginner_3',
        title: 'Daily Activities',
        description: 'Learn vocabulary and phrases for daily routines.',
        vocabulary: [
          'Se réveiller',
          'Se lever',
          'Se doucher',
          'Petit-déjeuner',
          'Aller au travail',
          'Déjeuner',
          'Dîner',
          'Se coucher',
          'Dormir',
          'Travailler',
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
          - Reflexive verbs use "se" before the verb
          - Common time expressions: le matin, l'après-midi, le soir
          - Adverbs: toujours, souvent, parfois, rarement, jamais
        ''',
        audioUrl: 'assets/audio/french/beginner/lesson3.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example3',
      ),
      CourseLesson(
        id: 'french_beginner_4',
        title: 'Food and Drinks',
        description:
            'Learn vocabulary for food, drinks, and ordering in restaurants.',
        vocabulary: [
          'Pain',
          'Fromage',
          'Vin',
          'Eau',
          'Café',
          'Thé',
          'Fruits',
          'Légumes',
          'Viande',
          'Poisson',
          'Je voudrais',
          'L\'addition',
          'Menu',
          'Serveur/Serveuse',
        ],
        grammarPoints: [
          'Partitive articles (du, de la, des)',
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
          - Use "je voudrais" to order
          - "L'addition, s'il vous plaît" to ask for the bill
          - Partitive articles indicate quantity
        ''',
        audioUrl: 'assets/audio/french/beginner/lesson4.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example4',
      ),
    ],
    imageUrl: 'assets/images/french_beginner.png',
    language: 'French',
  ),
  LanguageCourse(
    id: 'french_intermediate',
    title: 'Intermediate French',
    description:
        'Build on your French foundation with more complex grammar and vocabulary.',
    level: 'Intermediate',
    lessons: [
      CourseLesson(
        id: 'french_intermediate_1',
        title: 'Past Tenses',
        description:
            'Learn to talk about past events using different past tenses.',
        vocabulary: [
          'Hier',
          'La semaine dernière',
          'L\'année dernière',
          'Déjà',
          'Encore',
          'Jamais',
          'Toujours',
          'Souvent',
        ],
        grammarPoints: [
          'Passé composé',
          'Imparfait',
          'Plus-que-parfait',
          'Time expressions',
        ],
        exercises: [
          'Write about your last vacation',
          'Describe a childhood memory',
          'Compare past and present habits',
        ],
        notes: '''
          - Passé composé for completed actions
          - Imparfait for ongoing actions
          - Plus-que-parfait for actions before other past actions
        ''',
        audioUrl: 'assets/audio/french/intermediate/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example5',
      ),
      CourseLesson(
        id: 'french_intermediate_2',
        title: 'Future and Conditional',
        description:
            'Learn to express future plans and hypothetical situations.',
        vocabulary: [
          'Demain',
          'La semaine prochaine',
          'L\'année prochaine',
          'Bientôt',
          'Plus tard',
          'Si',
          'Quand',
          'Dès que',
        ],
        grammarPoints: [
          'Future simple',
          'Conditional mood',
          'Si clauses',
          'Future perfect',
        ],
        exercises: [
          'Make future plans',
          'Discuss hypothetical situations',
          'Write about future goals',
        ],
        notes: '''
          - Future simple for definite future actions
          - Conditional for polite requests
          - Si clauses express conditions
        ''',
        audioUrl: 'assets/audio/french/intermediate/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example6',
      ),
    ],
    imageUrl: 'assets/images/french_intermediate.png',
    language: 'French',
  ),
  LanguageCourse(
    id: 'french_advanced',
    title: 'Advanced French',
    description:
        'Master complex grammar structures and expand your vocabulary.',
    level: 'Advanced',
    lessons: [
      CourseLesson(
        id: 'french_advanced_1',
        title: 'Subjunctive Mood',
        description: 'Learn to use the subjunctive mood in various contexts.',
        vocabulary: [
          'Bien que',
          'Pour que',
          'Afin que',
          'Avant que',
          'Jusqu\'à ce que',
          'Sans que',
          'À moins que',
          'De peur que',
        ],
        grammarPoints: [
          'Subjunctive formation',
          'Subjunctive triggers',
          'Subjunctive vs indicative',
          'Complex sentence structures',
        ],
        exercises: [
          'Write persuasive arguments',
          'Express emotions and doubts',
          'Create complex sentences',
        ],
        notes: '''
          - Subjunctive expresses doubt, emotion, necessity
          - Used after certain conjunctions
          - Irregular subjunctive forms
        ''',
        audioUrl: 'assets/audio/french/advanced/lesson1.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example7',
      ),
      CourseLesson(
        id: 'french_advanced_2',
        title: 'Business French',
        description: 'Learn professional communication skills in French.',
        vocabulary: [
          'Entreprise',
          'Réunion',
          'Présentation',
          'Négociation',
          'Contrat',
          'Budget',
          'Client',
          'Fournisseur',
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
        audioUrl: 'assets/audio/french/advanced/lesson2.mp3',
        videoUrl: 'https://www.youtube.com/watch?v=example8',
      ),
    ],
    imageUrl: 'assets/images/french_advanced.png',
    language: 'French',
  ),
];
