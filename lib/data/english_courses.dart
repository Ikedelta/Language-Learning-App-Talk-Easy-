import '../models/language_course.dart';

final List<LanguageCourse> englishCourses = [
  LanguageCourse(
    id: 'eng_beg_1',
    title: 'English for Beginners',
    description:
        'Start your English learning journey with basic vocabulary and grammar. Perfect for absolute beginners.',
    level: 'Beginner',
    language: 'English',
    imageUrl: 'assets/images/english_beginner.jpg',
    lessons: [
      CourseLesson(
        id: 'eng_beg_1_1',
        title: 'Greetings and Introductions',
        description:
            'Learn how to greet people and introduce yourself in English.',
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
      CourseLesson(
        id: 'eng_beg_1_3',
        title: 'Daily Activities',
        description:
            'Learn vocabulary and phrases for common daily activities.',
        vocabulary: [
          'Wake up',
          'Get dressed',
          'Have breakfast',
          'Go to work',
          'Have lunch',
          'Go home',
          'Have dinner',
          'Go to bed',
          'Take a shower',
          'Brush teeth'
        ],
        grammarPoints: [
          'Present simple tense for routines',
          'Time expressions',
          'Adverbs of frequency',
          'Daily routine questions'
        ],
        exercises: [
          'Describe your daily routine',
          'Create a daily schedule',
          'Ask about someone\'s daily activities',
          'Write about your ideal day'
        ],
        audioUrl: 'assets/audio/eng_beg_1_3.mp3',
        videoUrl: 'assets/video/eng_beg_1_3.mp4',
        notes: '''
# Daily Activities

## Common Daily Routines
1. Morning Routine
   - Wake up
   - Get dressed
   - Have breakfast
   - Go to work/school

2. Afternoon Activities
   - Have lunch
   - Work/Study
   - Take a break
   - Go home

3. Evening Routine
   - Have dinner
   - Watch TV
   - Read a book
   - Go to bed

## Time Expressions
- In the morning
- In the afternoon
- In the evening
- At night
- At [specific time]

## Adverbs of Frequency
- Always
- Usually
- Often
- Sometimes
- Never

## Practice Dialogues
1. Morning Routine:
   A: What time do you wake up?
   B: I wake up at 7:00 AM.
   A: What do you do after waking up?
   B: I take a shower and have breakfast.

2. Evening Routine:
   A: What do you do in the evening?
   B: I have dinner at 7:00 PM and watch TV.
   A: What time do you go to bed?
   B: I usually go to bed at 10:00 PM.
''',
      ),
      CourseLesson(
        id: 'eng_beg_1_4',
        title: 'Food and Drinks',
        description:
            'Learn vocabulary and phrases related to food, drinks, and ordering at restaurants.',
        vocabulary: [
          'Breakfast',
          'Lunch',
          'Dinner',
          'Water',
          'Coffee',
          'Tea',
          'Bread',
          'Rice',
          'Meat',
          'Vegetables',
          'Fruits',
          'Dessert'
        ],
        grammarPoints: [
          'Countable and uncountable nouns',
          'Some and any',
          'Would like',
          'Ordering food'
        ],
        exercises: [
          'Create a shopping list',
          'Order food at a restaurant',
          'Describe your favorite meal',
          'Plan a menu for a party'
        ],
        audioUrl: 'assets/audio/eng_beg_1_4.mp3',
        videoUrl: 'assets/video/eng_beg_1_4.mp4',
        notes: '''
# Food and Drinks

## Common Foods
1. Breakfast
   - Bread
   - Eggs
   - Cereal
   - Fruit

2. Lunch/Dinner
   - Rice
   - Meat
   - Vegetables
   - Salad

3. Drinks
   - Water
   - Coffee
   - Tea
   - Juice

## Ordering Food
- I would like...
- Can I have...
- What would you like?
- Do you have...?

## Countable vs Uncountable
Countable:
- An apple
- Two sandwiches
- Three cups of coffee

Uncountable:
- Some rice
- Some water
- Some bread

## Practice Dialogues
1. At a Restaurant:
   A: What would you like to order?
   B: I would like a sandwich and a cup of coffee.
   A: Would you like anything else?
   B: No, thank you.

2. At a Cafe:
   A: Can I have a cup of tea, please?
   B: Would you like milk and sugar?
   A: Yes, please. And a piece of cake.
''',
      ),
    ],
  ),
  LanguageCourse(
    id: 'eng_int_1',
    title: 'Intermediate English',
    description:
        'Build on your basic English skills with more complex grammar and vocabulary.',
    level: 'Intermediate',
    language: 'English',
    imageUrl: 'assets/images/english_intermediate.jpg',
    lessons: [
      CourseLesson(
        id: 'eng_int_1_1',
        title: 'Past Tenses',
        description:
            'Learn to talk about past events using different past tenses.',
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
        description:
            'Learn to express hypothetical situations and their consequences.',
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
      CourseLesson(
        id: 'eng_int_1_3',
        title: 'Present Perfect Tense',
        description:
            'Learn to talk about experiences and actions that started in the past and continue to the present.',
        vocabulary: [
          'Experience',
          'Achievement',
          'Result',
          'Change',
          'Duration',
          'Since',
          'For',
          'Already',
          'Yet',
          'Just'
        ],
        grammarPoints: [
          'Present perfect structure',
          'Regular and irregular past participles',
          'Time expressions with present perfect',
          'Present perfect vs past simple'
        ],
        exercises: [
          'Write about your life experiences',
          'Create a list of achievements',
          'Interview a partner about their experiences',
          'Write a travel blog entry'
        ],
        audioUrl: 'assets/audio/eng_int_1_3.mp3',
        videoUrl: 'assets/video/eng_int_1_3.mp4',
        notes: '''
# Present Perfect Tense

## Structure
- Subject + have/has + past participle
- Example: I have visited Paris.

## Uses
1. Experiences
   - I have been to Japan.
   - She has never eaten sushi.

2. Changes over time
   - The city has grown a lot.
   - Technology has improved.

3. Achievements
   - Scientists have discovered a new planet.
   - I have finished my project.

## Time Expressions
- Ever
- Never
- Already
- Yet
- Just
- Since
- For

## Practice Exercises
1. Write about your travel experiences
2. List your achievements this year
3. Describe changes in your life
4. Interview a partner about their experiences
''',
      ),
      CourseLesson(
        id: 'eng_int_1_4',
        title: 'Reported Speech',
        description: 'Learn how to report what someone else has said.',
        vocabulary: [
          'Report',
          'Quote',
          'Statement',
          'Question',
          'Command',
          'Request',
          'Advice',
          'Promise',
          'Warning',
          'Suggestion'
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
        audioUrl: 'assets/audio/eng_int_1_4.mp3',
        videoUrl: 'assets/video/eng_int_1_4.mp4',
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
    ],
  ),
  LanguageCourse(
    id: 'eng_adv_1',
    title: 'Advanced English',
    description:
        'Master complex grammar structures and expand your vocabulary for professional and academic contexts.',
    level: 'Advanced',
    language: 'English',
    imageUrl: 'assets/images/english_advanced.jpg',
    lessons: [
      CourseLesson(
        id: 'eng_adv_1_1',
        title: 'Advanced Grammar Structures',
        description:
            'Learn complex grammatical structures used in formal and academic English.',
        vocabulary: [
          'Subjunctive mood',
          'Inversion',
          'Cleft sentences',
          'Emphatic structures'
        ],
        grammarPoints: [
          'Subjunctive mood',
          'Inversion after negative adverbials',
          'Cleft sentences for emphasis',
          'Advanced conditionals'
        ],
        exercises: [
          'Rewrite sentences using inversion',
          'Create cleft sentences for emphasis',
          'Practice subjunctive mood in formal contexts',
          'Write complex conditional sentences'
        ],
        audioUrl: 'assets/audio/eng_adv_1_1.mp3',
        videoUrl: 'assets/video/eng_adv_1_1.mp4',
        notes: '''
# Advanced Grammar Structures

## Subjunctive Mood
Used to express wishes, suggestions, and hypothetical situations.

### Examples:
- I suggest that he be present at the meeting.
- It's important that she arrive on time.

## Inversion
Used for emphasis and in formal writing.

### Examples:
- Never have I seen such a beautiful sunset.
- Not only did he finish the project, but he also exceeded expectations.

## Cleft Sentences
Used to emphasize specific information.

### Examples:
- What I need is more time.
- It was the manager who made the final decision.

## Practice Exercises
1. Rewrite sentences using inversion
2. Create cleft sentences for emphasis
3. Write formal suggestions using subjunctive
4. Combine different advanced structures
''',
      ),
      CourseLesson(
        id: 'eng_adv_1_2',
        title: 'Academic Writing',
        description:
            'Develop skills for writing academic papers and formal documents.',
        vocabulary: [
          'Thesis statement',
          'Literature review',
          'Methodology',
          'Citation styles'
        ],
        grammarPoints: [
          'Formal academic style',
          'Citation and referencing',
          'Academic vocabulary',
          'Complex sentence structures'
        ],
        exercises: [
          'Write an academic abstract',
          'Create a literature review',
          'Practice proper citation',
          'Develop a research proposal'
        ],
        audioUrl: 'assets/audio/eng_adv_1_2.mp3',
        videoUrl: 'assets/video/eng_adv_1_2.mp4',
        notes: '''
# Academic Writing

## Structure of Academic Papers
1. Abstract
2. Introduction
3. Literature Review
4. Methodology
5. Results
6. Discussion
7. Conclusion
8. References

## Academic Style
- Use formal language
- Avoid contractions
- Use passive voice appropriately
- Maintain objectivity

## Citation Styles
- APA
- MLA
- Chicago
- Harvard

## Practice Exercises
1. Write an abstract for a research paper
2. Create a literature review outline
3. Practice proper citation
4. Develop a research proposal
''',
      ),
      CourseLesson(
        id: 'eng_adv_1_3',
        title: 'Business English',
        description:
            'Learn professional communication skills for the workplace.',
        vocabulary: [
          'Meeting',
          'Presentation',
          'Negotiation',
          'Deadline',
          'Budget',
          'Strategy',
          'Performance',
          'Leadership',
          'Teamwork',
          'Innovation'
        ],
        grammarPoints: [
          'Formal business language',
          'Email etiquette',
          'Meeting phrases',
          'Presentation skills'
        ],
        exercises: [
          'Write a business email',
          'Prepare a meeting agenda',
          'Create a presentation outline',
          'Role-play a business negotiation'
        ],
        audioUrl: 'assets/audio/eng_adv_1_3.mp3',
        videoUrl: 'assets/video/eng_adv_1_3.mp4',
        notes: '''
# Business English

## Professional Communication
1. Email Writing
   - Formal greetings
   - Clear subject lines
   - Professional tone
   - Proper closing

2. Meetings
   - Setting agendas
   - Leading discussions
   - Taking minutes
   - Following up

3. Presentations
   - Structuring content
   - Using visual aids
   - Handling questions
   - Managing time

## Common Business Phrases
- Let's get down to business
- I'd like to propose...
- Could you elaborate on that?
- Let's touch base next week

## Practice Exercises
1. Write a business proposal
2. Create a meeting agenda
3. Prepare a presentation
4. Role-play a negotiation
''',
      ),
      CourseLesson(
        id: 'eng_adv_1_4',
        title: 'Academic Writing',
        description:
            'Develop skills for writing academic papers and formal documents.',
        vocabulary: [
          'Thesis',
          'Argument',
          'Evidence',
          'Citation',
          'Analysis',
          'Conclusion',
          'Methodology',
          'Literature review',
          'Abstract',
          'References'
        ],
        grammarPoints: [
          'Academic style',
          'Citation formats',
          'Formal language',
          'Complex sentence structures'
        ],
        exercises: [
          'Write an academic abstract',
          'Create a literature review',
          'Practice proper citation',
          'Develop a research proposal'
        ],
        audioUrl: 'assets/audio/eng_adv_1_4.mp3',
        videoUrl: 'assets/video/eng_adv_1_4.mp4',
        notes: '''
# Academic Writing

## Structure of Academic Papers
1. Abstract
2. Introduction
3. Literature Review
4. Methodology
5. Results
6. Discussion
7. Conclusion
8. References

## Academic Style
- Use formal language
- Avoid contractions
- Use passive voice appropriately
- Maintain objectivity

## Citation Styles
- APA
- MLA
- Chicago
- Harvard

## Practice Exercises
1. Write an abstract for a research paper
2. Create a literature review outline
3. Practice proper citation
4. Develop a research proposal
''',
      ),
    ],
  ),
];
