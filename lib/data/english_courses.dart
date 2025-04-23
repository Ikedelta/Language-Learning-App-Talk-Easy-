import '../models/language_course.dart';

final List<LanguageCourse> englishCourses = [
  LanguageCourse(
    id: 'eng_beg_1',
    title: 'English for Beginners',
    description: 'Start your English learning journey with basic vocabulary and grammar. Perfect for absolute beginners.',
    level: 'Beginner',
    language: 'English',
    imageUrl: 'assets/images/english_beginner.jpg',
    lessons: [
      CourseLesson(
        id: 'eng_beg_1_1',
        title: 'Greetings and Introductions',
        description: 'Learn how to greet people and introduce yourself in English.',
        vocabulary: [
          'Hello',
          'Hi',
          'Good morning',
          'Good afternoon',
          'Good evening',
          'My name is...',
          'Nice to meet you',
          'How are you?',
          'I\'m fine, thank you',
          'Goodbye'
        ],
        grammarPoints: [
          'Basic sentence structure',
          'Subject pronouns (I, you, he, she, it, we, they)',
          'Present simple tense',
          'Question formation'
        ],
        exercises: [
          'Practice greeting different people',
          'Introduce yourself to a partner',
          'Write a short self-introduction',
          'Role-play common social situations'
        ],
        audioUrl: 'assets/audio/eng_beg_1_1.mp3',
        videoUrl: 'https://youtu.be/WQ4MaTlbg4o?si=Km_JEyTcG3AerqBc',
        notes: '''
# Greetings and Introductions

## Basic Greetings
- Hello / Hi
- Good morning (before 12pm)
- Good afternoon (12pm - 6pm)
- Good evening (after 6pm)

## Introducing Yourself
1. Start with a greeting
2. Say your name: "My name is [name]" or "I'm [name]"
3. Ask for the other person's name: "What's your name?"
4. Respond to their introduction: "Nice to meet you"

## Common Phrases
- How are you?
- I'm fine, thank you
- And you?
- Goodbye / Bye / See you later

## Practice Dialogues
1. Formal Introduction:
   A: Good morning. My name is John.
   B: Good morning, John. I'm Sarah. Nice to meet you.
   A: Nice to meet you too.

2. Informal Introduction:
   A: Hi! I'm Mike.
   B: Hi Mike! I'm Lisa.
   A: Nice to meet you, Lisa.
''',
      ),
      CourseLesson(
        id: 'eng_beg_1_2',
        title: 'Numbers and Time',
        description: 'Learn to count and tell time in English.',
        vocabulary: [
          'Numbers 1-100',
          'Days of the week',
          'Months of the year',
          'What time is it?',
          'Morning',
          'Afternoon',
          'Evening',
          'Night'
        ],
        grammarPoints: [
          'Cardinal numbers',
          'Ordinal numbers',
          'Time expressions',
          'Prepositions of time'
        ],
        exercises: [
          'Practice counting from 1-100',
          'Write the date in English',
          'Tell the time in different formats',
          'Create a daily schedule'
        ],
        audioUrl: 'assets/audio/eng_beg_1_2.mp3',
        videoUrl: 'assets/video/eng_beg_1_2.mp4',
        notes: '''
# Numbers and Time

## Numbers 1-20
1 - one
2 - two
3 - three
4 - four
5 - five
6 - six
7 - seven
8 - eight
9 - nine
10 - ten
11 - eleven
12 - twelve
13 - thirteen
14 - fourteen
15 - fifteen
16 - sixteen
17 - seventeen
18 - eighteen
19 - nineteen
20 - twenty

## Telling Time
- What time is it?
- It's [hour] o'clock
- It's [hour]:[minutes]
- AM/PM usage

## Days of the Week
- Monday
- Tuesday
- Wednesday
- Thursday
- Friday
- Saturday
- Sunday

## Months of the Year
- January
- February
- March
- April
- May
- June
- July
- August
- September
- October
- November
- December

## Practice Exercises
1. Write today's date
2. Tell the current time
3. Create a weekly schedule
4. Practice counting money
''',
      ),
    ],
  ),
  LanguageCourse(
    id: 'eng_int_1',
    title: 'Intermediate English',
    description: 'Build on your basic English skills with more complex grammar and vocabulary.',
    level: 'Intermediate',
    language: 'English',
    imageUrl: 'assets/images/english_intermediate.jpg',
    lessons: [
      CourseLesson(
        id: 'eng_int_1_1',
        title: 'Past Tenses',
        description: 'Learn to talk about past events using different past tenses.',
        vocabulary: [
          'Regular verbs',
          'Irregular verbs',
          'Time expressions',
          'Sequence words'
        ],
        grammarPoints: [
          'Simple past tense',
          'Past continuous tense',
          'Past perfect tense',
          'Used to + infinitive'
        ],
        exercises: [
          'Write about your last vacation',
          'Describe a childhood memory',
          'Tell a story using different past tenses',
          'Practice irregular verb forms'
        ],
        audioUrl: 'assets/audio/eng_int_1_1.mp3',
        videoUrl: 'assets/video/eng_int_1_1.mp4',
        notes: '''
# Past Tenses

## Simple Past Tense
Used for completed actions in the past.

### Regular Verbs
- Add -ed to the base form
- Example: walk → walked, play → played

### Irregular Verbs
- Must be memorized
- Example: go → went, eat → ate

## Past Continuous Tense
Used for actions in progress in the past.

### Structure
- Subject + was/were + verb-ing
- Example: I was studying when you called.

## Past Perfect Tense
Used for actions completed before another past action.

### Structure
- Subject + had + past participle
- Example: I had finished my homework before dinner.

## Practice Exercises
1. Write a diary entry about yesterday
2. Describe what you were doing at specific times
3. Tell a story using all past tenses
4. Practice irregular verb forms
''',
      ),
      CourseLesson(
        id: 'eng_int_1_2',
        title: 'Conditionals',
        description: 'Learn to express hypothetical situations and their consequences.',
        vocabulary: [
          'If clauses',
          'Result clauses',
          'Modal verbs',
          'Conjunctions'
        ],
        grammarPoints: [
          'Zero conditional',
          'First conditional',
          'Second conditional',
          'Third conditional'
        ],
        exercises: [
          'Create conditional sentences',
          'Role-play hypothetical situations',
          'Write about your dreams and wishes',
          'Discuss possible future scenarios'
        ],
        audioUrl: 'assets/audio/eng_int_1_2.mp3',
        videoUrl: 'assets/video/eng_int_1_2.mp4',
        notes: '''
# Conditionals

## Zero Conditional
Used for general truths and facts.

### Structure
- If + present simple, present simple
- Example: If you heat ice, it melts.

## First Conditional
Used for possible future situations.

### Structure
- If + present simple, will + base verb
- Example: If it rains, I will stay home.

## Second Conditional
Used for hypothetical present situations.

### Structure
- If + past simple, would + base verb
- Example: If I had money, I would travel.

## Third Conditional
Used for hypothetical past situations.

### Structure
- If + past perfect, would have + past participle
- Example: If I had studied, I would have passed.

## Practice Exercises
1. Create sentences for each conditional type
2. Role-play different scenarios
3. Write about your dreams and wishes
4. Discuss possible future scenarios
''',
      ),
    ],
  ),
  LanguageCourse(
    id: 'eng_adv_1',
    title: 'Advanced English',
    description: 'Master complex grammar structures and expand your vocabulary for fluent communication.',
    level: 'Advanced',
    language: 'English',
    imageUrl: 'assets/images/english_advanced.jpg',
    lessons: [
      CourseLesson(
        id: 'eng_adv_1_1',
        title: 'Reported Speech',
        description: 'Learn how to report what someone else has said.',
        vocabulary: [
          'Reporting verbs',
          'Time expressions',
          'Pronouns',
          'Tense changes'
        ],
        grammarPoints: [
          'Direct to indirect speech',
          'Tense changes',
          'Pronoun changes',
          'Time expression changes'
        ],
        exercises: [
          'Convert direct speech to reported speech',
          'Write a news report',
          'Tell a story using reported speech',
          'Practice different reporting verbs'
        ],
        audioUrl: 'assets/audio/eng_adv_1_1.mp3',
        videoUrl: 'assets/video/eng_adv_1_1.mp4',
        notes: '''
# Reported Speech

## Basic Rules
1. Change pronouns
2. Change tenses
3. Change time expressions
4. Change place expressions

## Tense Changes
- Present simple → Past simple
- Present continuous → Past continuous
- Present perfect → Past perfect
- Past simple → Past perfect
- Will → Would
- Can → Could
- May → Might
- Must → Had to

## Example
Direct: "I am going to the store."
Reported: He said he was going to the store.

## Practice Exercises
1. Convert direct speech to reported speech
2. Write a news report
3. Tell a story using reported speech
4. Practice different reporting verbs
''',
      ),
      CourseLesson(
        id: 'eng_adv_1_2',
        title: 'Idioms and Phrasal Verbs',
        description: 'Learn common English idioms and phrasal verbs for natural communication.',
        vocabulary: [
          'Common idioms',
          'Phrasal verbs',
          'Collocations',
          'Expressions'
        ],
        grammarPoints: [
          'Idiom usage',
          'Phrasal verb patterns',
          'Collocation rules',
          'Expression context'
        ],
        exercises: [
          'Create sentences with idioms',
          'Practice phrasal verbs in context',
          'Write a story using idioms',
          'Role-play using expressions'
        ],
        audioUrl: 'assets/audio/eng_adv_1_2.mp3',
        videoUrl: 'assets/video/eng_adv_1_2.mp4',
        notes: '''
# Idioms and Phrasal Verbs

## Common Idioms
1. Break a leg - Good luck
2. Hit the books - Study
3. Pull someone's leg - Joke with someone
4. Under the weather - Feeling sick
5. Spill the beans - Reveal a secret

## Phrasal Verbs
1. Look up - Search for information
2. Give up - Stop trying
3. Take off - Remove or leave
4. Put off - Postpone
5. Turn down - Reject

## Practice Exercises
1. Create sentences with idioms
2. Practice phrasal verbs in context
3. Write a story using idioms
4. Role-play using expressions
''',
      ),
    ],
  ),
]; 