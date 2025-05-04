import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/language_course.dart';

class CourseContentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeDefaultCourses() async {
    // English Courses
    await _addCourse(getEnglishBeginnerCourse());
    await _addCourse(getEnglishIntermediateCourse());
    await _addCourse(getEnglishAdvancedCourse());

    // Spanish Courses
    await _addCourse(getSpanishBeginnerCourse());
    await _addCourse(getSpanishIntermediateCourse());
    await _addCourse(getSpanishAdvancedCourse());

    // French Courses
    await _addCourse(getFrenchBeginnerCourse());
    await _addCourse(getFrenchIntermediateCourse());
    await _addCourse(getFrenchAdvancedCourse());

    // German Courses
    await _addCourse(getGermanBeginnerCourse());
    await _addCourse(getGermanIntermediateCourse());
    await _addCourse(getGermanAdvancedCourse());

    // Japanese Courses
    await _addCourse(getJapaneseBeginnerCourse());
    await _addCourse(getJapaneseIntermediateCourse());
    await _addCourse(getJapaneseAdvancedCourse());
  }

  Future<void> _addCourse(LanguageCourse course) async {
    final courseDoc = _firestore.collection('courses').doc(course.id);

    if (!(await courseDoc.get()).exists) {
      await courseDoc.set({
        'title': course.title,
        'description': course.description,
        'level': course.level,
        'imageUrl': course.imageUrl,
        'language': course.language,
        'lessons': course.lessons
            .map((lesson) => {
                  'id': lesson.id,
                  'title': lesson.title,
                  'description': lesson.description,
                  'vocabulary': lesson.vocabulary,
                  'grammarPoints': lesson.grammarPoints,
                  'exercises': lesson.exercises,
                  'audioUrl': lesson.audioUrl,
                  'videoUrl': lesson.videoUrl,
                  'notes': lesson.notes,
                })
            .toList(),
      });
    }
  }

  LanguageCourse getEnglishBeginnerCourse() {
    return LanguageCourse(
        id: 'english_beginner',
        title: 'English for Beginners',
        description:
            'Start your journey in English with essential vocabulary and basic grammar',
        level: 'Beginner',
        imageUrl: 'assets/images/english_beginner.jpg',
        language: 'English',
        lessons: [
          CourseLesson(
              id: 'eb_1',
              title: 'Greetings and Introductions',
              description: 'Learn how to greet people and introduce yourself',
              vocabulary: [
                'Hello',
                'Hi',
                'Good morning',
                'Good afternoon',
                'Good evening',
                'My name is...',
                'Nice to meet you',
                'How are you?',
                'I am fine',
                'Thank you',
                'You\'re welcome',
                'Goodbye',
                'See you later'
              ],
              grammarPoints: [
                'Personal pronouns (I, you, he, she, it, we, they)',
                'The verb "to be" in present tense',
                'Basic sentence structure: subject + verb + object',
                'Question words (what, who, how)'
              ],
              exercises: [
                'Practice introducing yourself to three different people',
                'Role-play: Meeting someone for the first time',
                'Fill in the blanks with appropriate greetings',
                'Match greetings with appropriate responses'
              ],
              audioUrl: 'assets/audio/greetings.mp3',
              videoUrl: 'assets/video/introductions.mp4',
              notes:
                  'Remember to maintain eye contact and smile when greeting someone!'),
          CourseLesson(
              id: 'eb_2',
              title: 'Numbers and Counting',
              description: 'Master numbers from 1-100 and basic counting',
              vocabulary: [
                'Numbers 1-100',
                'First, second, third...',
                'Count, number, sum, total',
                'Plus, minus, equals',
                'How many?',
                'How much?'
              ],
              grammarPoints: [
                'Cardinal numbers vs. ordinal numbers',
                'Singular and plural nouns',
                'Quantifiers (many, much, a lot of)',
                'Basic mathematical expressions'
              ],
              exercises: [
                'Count objects in the classroom',
                'Write numbers in words',
                'Solve simple math problems in English',
                'Order numbers from smallest to largest'
              ],
              audioUrl: 'assets/audio/numbers.mp3',
              videoUrl: 'assets/video/counting.mp4',
              notes: 'Practice counting out loud to improve pronunciation!')
        ]);
  }

  LanguageCourse getSpanishBeginnerCourse() {
    return LanguageCourse(
        id: 'spanish_beginner',
        title: 'Spanish for Beginners',
        description:
            '¡Comienza tu viaje en español! Start your Spanish journey with essential phrases',
        level: 'Beginner',
        imageUrl: 'assets/images/spanish_beginner.jpg',
        language: 'Spanish',
        lessons: [
          CourseLesson(
              id: 'sb_1',
              title: 'Basic Greetings and Introductions',
              description:
                  'Learn essential Spanish greetings and how to introduce yourself',
              vocabulary: [
                '¡Hola! - Hello',
                'Buenos días - Good morning',
                'Buenas tardes - Good afternoon',
                'Buenas noches - Good night',
                'Me llamo... - My name is...',
                'Mucho gusto - Nice to meet you',
                '¿Cómo estás? - How are you?',
                'Estoy bien - I am fine',
                'Gracias - Thank you',
                'De nada - You\'re welcome',
                'Adiós - Goodbye',
                'Hasta luego - See you later'
              ],
              grammarPoints: [
                'Personal pronouns (yo, tú, él, ella, nosotros, ellos)',
                'The verb "ser" in present tense',
                'Basic sentence structure in Spanish',
                'Question words (qué, quién, cómo)'
              ],
              exercises: [
                'Practice introducing yourself in Spanish',
                'Role-play: Meeting someone in a Spanish-speaking country',
                'Match Spanish greetings with their English translations',
                'Fill in the blanks with appropriate pronouns'
              ],
              audioUrl: 'assets/audio/spanish_greetings.mp3',
              videoUrl: 'assets/video/spanish_introductions.mp4',
              notes:
                  '¡Remember that Spanish uses inverted exclamation (¡) and question marks (¿)!')
        ]);
  }

  LanguageCourse getFrenchBeginnerCourse() {
    return LanguageCourse(
        id: 'french_beginner',
        title: 'French for Beginners',
        description:
            'Commencez votre voyage en français! Start your French journey',
        level: 'Beginner',
        imageUrl: 'assets/images/french_beginner.jpg',
        language: 'French',
        lessons: [
          CourseLesson(
              id: 'fb_1',
              title: 'Essential French Greetings',
              description: 'Master basic French greetings and introductions',
              vocabulary: [
                'Bonjour - Hello/Good day',
                'Bonsoir - Good evening',
                'Au revoir - Goodbye',
                'Je m\'appelle... - My name is...',
                'Comment allez-vous? - How are you?',
                'Très bien, merci - Very well, thank you',
                'S\'il vous plaît - Please',
                'Merci - Thank you',
                'De rien - You\'re welcome'
              ],
              grammarPoints: [
                'French personal pronouns (je, tu, il, elle, nous, vous, ils, elles)',
                'The verb "être" (to be) in present tense',
                'Basic French pronunciation rules',
                'Formal vs. informal address (tu vs. vous)'
              ],
              exercises: [
                'Practice French pronunciation',
                'Role-play: Meeting someone in Paris',
                'Match French phrases with their meanings',
                'Complete dialogue exercises'
              ],
              audioUrl: 'assets/audio/french_greetings.mp3',
              videoUrl: 'assets/video/french_introductions.mp4',
              notes:
                  'Pay attention to formal and informal situations when choosing between tu and vous!')
        ]);
  }

  LanguageCourse getEnglishIntermediateCourse() {
    return LanguageCourse(
        id: 'english_intermediate',
        title: 'Intermediate English',
        description:
            'Advance your English skills with complex grammar and vocabulary',
        level: 'Intermediate',
        imageUrl: 'assets/images/english_intermediate.jpg',
        language: 'English',
        lessons: [
          CourseLesson(
              id: 'ei_1',
              title: 'Perfect Tenses',
              description:
                  'Master the present perfect, past perfect, and future perfect tenses',
              vocabulary: [
                'Already',
                'Yet',
                'Just',
                'Ever',
                'Never',
                'Since',
                'For',
                'Recently',
                'Lately',
                'By the time',
                'Before',
                'After'
              ],
              grammarPoints: [
                'Present Perfect: have/has + past participle',
                'Past Perfect: had + past participle',
                'Future Perfect: will have + past participle',
                'Time expressions with perfect tenses'
              ],
              exercises: [
                'Complete sentences using the correct perfect tense',
                'Write about your life experiences using present perfect',
                'Create a timeline of events using past perfect',
                'Describe future accomplishments using future perfect'
              ],
              audioUrl: 'assets/audio/perfect_tenses.mp3',
              videoUrl: 'assets/video/perfect_tenses.mp4',
              notes:
                  'Perfect tenses connect different time periods - focus on the relationship between times!')
        ]);
  }

  LanguageCourse getEnglishAdvancedCourse() {
    return LanguageCourse(
        id: 'english_advanced',
        title: 'Advanced English',
        description:
            'Master complex English concepts and achieve native-like fluency',
        level: 'Advanced',
        imageUrl: 'assets/images/english_advanced.jpg',
        language: 'English',
        lessons: [
          CourseLesson(
              id: 'ea_1',
              title: 'Academic Writing',
              description:
                  'Learn to write sophisticated academic papers and essays',
              vocabulary: [
                'Furthermore',
                'Moreover',
                'Nevertheless',
                'Consequently',
                'Therefore',
                'However',
                'Despite',
                'Although',
                'Notwithstanding'
              ],
              grammarPoints: [
                'Complex sentence structures',
                'Academic tone and style',
                'Passive voice in academic writing',
                'Hedging language and qualifiers'
              ],
              exercises: [
                'Write a research paper introduction',
                'Practice using academic transitions',
                'Analyze academic journal articles',
                'Peer review writing assignments'
              ],
              audioUrl: 'assets/audio/academic_writing.mp3',
              videoUrl: 'assets/video/academic_writing.mp4',
              notes: 'Academic writing requires precision and formal language!')
        ]);
  }

  LanguageCourse getSpanishIntermediateCourse() {
    return LanguageCourse(
        id: 'spanish_intermediate',
        title: 'Intermediate Spanish',
        description:
            '¡Mejora tu español! Improve your Spanish with advanced concepts',
        level: 'Intermediate',
        imageUrl: 'assets/images/spanish_intermediate.jpg',
        language: 'Spanish',
        lessons: [
          CourseLesson(
              id: 'si_1',
              title: 'Past Tenses in Spanish',
              description:
                  'Master the differences between preterite and imperfect',
              vocabulary: [
                'Ayer - Yesterday',
                'La semana pasada - Last week',
                'Mientras - While',
                'Siempre - Always',
                'Nunca - Never'
              ],
              grammarPoints: [
                'Preterite tense conjugations',
                'Imperfect tense conjugations',
                'When to use preterite vs. imperfect',
                'Time expressions with past tenses'
              ],
              exercises: [
                'Write about your childhood using imperfect',
                'Describe a specific event using preterite',
                'Mixed tense story writing',
                'Past tense conjugation practice'
              ],
              audioUrl: 'assets/audio/spanish_past.mp3',
              videoUrl: 'assets/video/spanish_past.mp4',
              notes:
                  'The choice between preterite and imperfect depends on the context!')
        ]);
  }

  LanguageCourse getSpanishAdvancedCourse() {
    return LanguageCourse(
        id: 'spanish_advanced',
        title: 'Advanced Spanish',
        description: '¡Domina el español! Master Spanish like a native speaker',
        level: 'Advanced',
        imageUrl: 'assets/images/spanish_advanced.jpg',
        language: 'Spanish',
        lessons: [
          CourseLesson(
              id: 'sa_1',
              title: 'Subjunctive Mood',
              description: 'Master the complex uses of the Spanish subjunctive',
              vocabulary: [
                'Ojalá - I hope',
                'Quizás - Maybe',
                'Es posible que - It\'s possible that',
                'Dudo que - I doubt that'
              ],
              grammarPoints: [
                'Present subjunctive conjugations',
                'Past subjunctive conjugations',
                'Triggers for subjunctive use',
                'Subjunctive in relative clauses'
              ],
              exercises: [
                'Express wishes using subjunctive',
                'Write conditional sentences',
                'Practice subjunctive triggers',
                'Create complex sentences with multiple clauses'
              ],
              audioUrl: 'assets/audio/spanish_subjunctive.mp3',
              videoUrl: 'assets/video/spanish_subjunctive.mp4',
              notes:
                  'The subjunctive is used to express uncertainty, desires, and emotions!')
        ]);
  }

  LanguageCourse getFrenchIntermediateCourse() {
    return LanguageCourse(
        id: 'french_intermediate',
        title: 'Intermediate French',
        description:
            'Améliorez votre français! Improve your French with advanced concepts',
        level: 'Intermediate',
        imageUrl: 'assets/images/french_intermediate.jpg',
        language: 'French',
        lessons: [
          CourseLesson(
              id: 'fi_1',
              title: 'Past Tenses in French',
              description: 'Master the passé composé and imparfait',
              vocabulary: [
                'Hier - Yesterday',
                'La semaine dernière - Last week',
                'Pendant - During',
                'Toujours - Always',
                'Jamais - Never'
              ],
              grammarPoints: [
                'Passé composé formation',
                'Imparfait conjugations',
                'Choosing between passé composé and imparfait',
                'Past participle agreement'
              ],
              exercises: [
                'Write about your past experiences',
                'Describe childhood memories',
                'Practice past tense conjugations',
                'Create a story using both past tenses'
              ],
              audioUrl: 'assets/audio/french_past.mp3',
              videoUrl: 'assets/video/french_past.mp4',
              notes:
                  'Pay attention to which auxiliary verb (avoir or être) to use in passé composé!')
        ]);
  }

  LanguageCourse getFrenchAdvancedCourse() {
    return LanguageCourse(
        id: 'french_advanced',
        title: 'Advanced French',
        description:
            'Maîtrisez le français! Master French like a native speaker',
        level: 'Advanced',
        imageUrl: 'assets/images/french_advanced.jpg',
        language: 'French',
        lessons: [
          CourseLesson(
              id: 'fa_1',
              title: 'Le Subjonctif',
              description: 'Master the French subjunctive mood',
              vocabulary: [
                'Il faut que - It is necessary that',
                'Je veux que - I want that',
                'Bien que - Although',
                'Pour que - So that'
              ],
              grammarPoints: [
                'Subjunctive formation',
                'Triggers for subjunctive use',
                'Subjunctive vs. indicative',
                'Common expressions with subjunctive'
              ],
              exercises: [
                'Express necessity using subjunctive',
                'Write sentences with emotion verbs',
                'Practice irregular subjunctive forms',
                'Create complex sentences'
              ],
              audioUrl: 'assets/audio/french_subjunctive.mp3',
              videoUrl: 'assets/video/french_subjunctive.mp4',
              notes:
                  'The subjunctive is essential for expressing abstract concepts in French!')
        ]);
  }

  LanguageCourse getGermanBeginnerCourse() {
    return LanguageCourse(
        id: 'german_beginner',
        title: 'German for Beginners',
        description:
            'Beginnen Sie Ihre Deutschreise! Start your German journey',
        level: 'Beginner',
        imageUrl: 'assets/images/german_beginner.jpg',
        language: 'German',
        lessons: [
          CourseLesson(
              id: 'gb_1',
              title: 'Basic German Greetings',
              description: 'Learn essential German greetings and introductions',
              vocabulary: [
                'Hallo - Hello',
                'Guten Morgen - Good morning',
                'Guten Tag - Good day',
                'Auf Wiedersehen - Goodbye',
                'Ich heiße... - My name is...'
              ],
              grammarPoints: [
                'Personal pronouns',
                'The verb "sein" (to be)',
                'Basic word order',
                'Question words'
              ],
              exercises: [
                'Practice German pronunciation',
                'Introduce yourself in German',
                'Role-play basic conversations',
                'Match greetings with situations'
              ],
              audioUrl: 'assets/audio/german_greetings.mp3',
              videoUrl: 'assets/video/german_introductions.mp4',
              notes: 'Pay attention to formal (Sie) vs. informal (du) address!')
        ]);
  }

  LanguageCourse getGermanIntermediateCourse() {
    return LanguageCourse(
        id: 'german_intermediate',
        title: 'Intermediate German',
        description: 'Verbessern Sie Ihr Deutsch! Improve your German',
        level: 'Intermediate',
        imageUrl: 'assets/images/german_intermediate.jpg',
        language: 'German',
        lessons: [
          CourseLesson(
              id: 'gi_1',
              title: 'German Cases',
              description: 'Master the four German cases',
              vocabulary: [
                'Der/Die/Das - The',
                'Ein/Eine - A/An',
                'Diesem/Dieser - This',
                'Prepositions with cases'
              ],
              grammarPoints: [
                'Nominative case',
                'Accusative case',
                'Dative case',
                'Genitive case'
              ],
              exercises: [
                'Practice case declensions',
                'Write sentences using different cases',
                'Identify cases in texts',
                'Use prepositions correctly'
              ],
              audioUrl: 'assets/audio/german_cases.mp3',
              videoUrl: 'assets/video/german_cases.mp4',
              notes: 'Cases are essential for correct German grammar!')
        ]);
  }

  LanguageCourse getGermanAdvancedCourse() {
    return LanguageCourse(
        id: 'german_advanced',
        title: 'Advanced German',
        description:
            'Meistern Sie die deutsche Sprache! Master the German language',
        level: 'Advanced',
        imageUrl: 'assets/images/german_advanced.jpg',
        language: 'German',
        lessons: [
          CourseLesson(
              id: 'ga_1',
              title: 'Complex Sentence Structures',
              description: 'Master German sentence structure and word order',
              vocabulary: [
                'Subordinating conjunctions',
                'Coordinating conjunctions',
                'Modal particles',
                'Time expressions'
              ],
              grammarPoints: [
                'Verb position in subordinate clauses',
                'Multiple subordinate clauses',
                'Passive voice',
                'Extended attributes'
              ],
              exercises: [
                'Create complex sentences',
                'Transform active to passive voice',
                'Practice word order',
                'Write academic texts'
              ],
              audioUrl: 'assets/audio/german_complex.mp3',
              videoUrl: 'assets/video/german_complex.mp4',
              notes: 'German word order is flexible but follows strict rules!')
        ]);
  }

  LanguageCourse getJapaneseBeginnerCourse() {
    return LanguageCourse(
        id: 'japanese_beginner',
        title: 'Japanese for Beginners',
        description: '日本語を始めましょう！ Start your Japanese journey',
        level: 'Beginner',
        imageUrl: 'assets/images/japanese_beginner.jpg',
        language: 'Japanese',
        lessons: [
          CourseLesson(
              id: 'jb_1',
              title: 'Basic Japanese Greetings',
              description:
                  'Learn essential Japanese greetings and introductions',
              vocabulary: [
                'こんにちは (Konnichiwa) - Hello',
                'おはようございます (Ohayou gozaimasu) - Good morning',
                'さようなら (Sayounara) - Goodbye',
                'はじめまして (Hajimemashite) - Nice to meet you'
              ],
              grammarPoints: [
                'Basic sentence structure',
                'Polite form (-です/-ます)',
                'Personal pronouns',
                'Question particle か (ka)'
              ],
              exercises: [
                'Practice Japanese pronunciation',
                'Write hiragana characters',
                'Role-play basic conversations',
                'Match greetings with situations'
              ],
              audioUrl: 'assets/audio/japanese_greetings.mp3',
              videoUrl: 'assets/video/japanese_introductions.mp4',
              notes:
                  'Japanese has different levels of politeness - start with the polite form!')
        ]);
  }

  LanguageCourse getJapaneseIntermediateCourse() {
    return LanguageCourse(
        id: 'japanese_intermediate',
        title: 'Intermediate Japanese',
        description: '日本語を上達させましょう！ Improve your Japanese',
        level: 'Intermediate',
        imageUrl: 'assets/images/japanese_intermediate.jpg',
        language: 'Japanese',
        lessons: [
          CourseLesson(
              id: 'ji_1',
              title: 'Japanese Particles',
              description: 'Master the use of Japanese particles',
              vocabulary: [
                'は (wa) - Topic marker',
                'が (ga) - Subject marker',
                'を (wo) - Object marker',
                'に (ni) - Indirect object/location marker'
              ],
              grammarPoints: [
                'Particle usage rules',
                'Multiple particles in sentences',
                'Particle combinations',
                'Common particle patterns'
              ],
              exercises: [
                'Practice particle usage',
                'Create sentences with multiple particles',
                'Identify particles in texts',
                'Translate sentences using correct particles'
              ],
              audioUrl: 'assets/audio/japanese_particles.mp3',
              videoUrl: 'assets/video/japanese_particles.mp4',
              notes: 'Particles are crucial for conveying meaning in Japanese!')
        ]);
  }

  LanguageCourse getJapaneseAdvancedCourse() {
    return LanguageCourse(
        id: 'japanese_advanced',
        title: 'Advanced Japanese',
        description: '日本語をマスターしましょう！ Master the Japanese language',
        level: 'Advanced',
        imageUrl: 'assets/images/japanese_advanced.jpg',
        language: 'Japanese',
        lessons: [
          CourseLesson(
              id: 'ja_1',
              title: 'Keigo (Honorific Language)',
              description: 'Master Japanese honorific and humble forms',
              vocabulary: [
                'お/ご (O/Go) - Honorific prefixes',
                'いらっしゃる (Irassharu) - Honorific form of to come/go',
                'めしあがる (Meshiagaru) - Honorific form of to eat',
                'させていただく (Sasete itadaku) - Humble expression'
              ],
              grammarPoints: [
                'Honorific verbs',
                'Humble verbs',
                'Respectful prefixes',
                'Social context and usage'
              ],
              exercises: [
                'Convert casual to honorific forms',
                'Role-play business situations',
                'Write formal emails',
                'Practice proper social etiquette'
              ],
              audioUrl: 'assets/audio/japanese_keigo.mp3',
              videoUrl: 'assets/video/japanese_keigo.mp4',
              notes:
                  'Keigo is essential for professional and formal situations in Japan!')
        ]);
  }
}
