import '../models/language_course.dart';

final List<LanguageCourse> spanishCourses = [
  LanguageCourse(
    id: 'spa_beg_1',
    title: 'Spanish for Beginners',
    description: 'Start your Spanish learning journey with basic vocabulary and grammar. Perfect for absolute beginners.',
    level: 'Beginner',
    language: 'Spanish',
    imageUrl: 'assets/images/spanish_beginner.jpg',
    lessons: [
      CourseLesson(
        id: 'spa_beg_1_1',
        title: 'Saludos y Presentaciones',
        description: 'Aprende a saludar y presentarte en español.',
        vocabulary: [
          'Hola',
          'Buenos días',
          'Buenas tardes',
          'Buenas noches',
          'Me llamo...',
          'Mucho gusto',
          '¿Cómo estás?',
          'Bien, gracias',
          'Adiós'
        ],
        grammarPoints: [
          'Estructura básica de la oración',
          'Pronombres personales (yo, tú, él, ella, nosotros, ustedes, ellos)',
          'Presente simple',
          'Formación de preguntas'
        ],
        exercises: [
          'Practicar saludos con diferentes personas',
          'Presentarte a un compañero',
          'Escribir una breve presentación personal',
          'Jugar roles en situaciones sociales comunes'
        ],
        audioUrl: 'assets/audio/spa_beg_1_1.mp3',
        videoUrl: 'assets/video/spa_beg_1_1.mp4',
        notes: '''
# Saludos y Presentaciones

## Saludos Básicos
- Hola
- Buenos días (mañana)
- Buenas tardes (tarde)
- Buenas noches (noche)

## Presentarse
1. Comienza con un saludo
2. Di tu nombre: "Me llamo [nombre]" o "Soy [nombre]"
3. Pregunta el nombre de la otra persona: "¿Cómo te llamas?"
4. Responde a su presentación: "Mucho gusto"

## Frases Comunes
- ¿Cómo estás?
- Bien, gracias
- ¿Y tú?
- Adiós / Hasta luego

## Diálogos de Práctica
1. Presentación Formal:
   A: Buenos días. Me llamo Juan.
   B: Buenos días, Juan. Soy María. Mucho gusto.
   A: Mucho gusto también.

2. Presentación Informal:
   A: ¡Hola! Soy Miguel.
   B: ¡Hola Miguel! Soy Laura.
   A: Mucho gusto, Laura.
''',
      ),
      CourseLesson(
        id: 'spa_beg_1_2',
        title: 'Números y Tiempo',
        description: 'Aprende a contar y decir la hora en español.',
        vocabulary: [
          'Números 1-100',
          'Días de la semana',
          'Meses del año',
          '¿Qué hora es?',
          'Mañana',
          'Tarde',
          'Noche'
        ],
        grammarPoints: [
          'Números cardinales',
          'Números ordinales',
          'Expresiones de tiempo',
          'Preposiciones de tiempo'
        ],
        exercises: [
          'Practicar contar del 1-100',
          'Escribir la fecha en español',
          'Decir la hora en diferentes formatos',
          'Crear un horario diario'
        ],
        audioUrl: 'assets/audio/spa_beg_1_2.mp3',
        videoUrl: 'assets/video/spa_beg_1_2.mp4',
        notes: '''
# Números y Tiempo

## Números 1-20
1 - uno
2 - dos
3 - tres
4 - cuatro
5 - cinco
6 - seis
7 - siete
8 - ocho
9 - nueve
10 - diez
11 - once
12 - doce
13 - trece
14 - catorce
15 - quince
16 - dieciséis
17 - diecisiete
18 - dieciocho
19 - diecinueve
20 - veinte

## Decir la Hora
- ¿Qué hora es?
- Es la una
- Son las [hora]
- Uso de AM/PM

## Días de la Semana
- lunes
- martes
- miércoles
- jueves
- viernes
- sábado
- domingo

## Meses del Año
- enero
- febrero
- marzo
- abril
- mayo
- junio
- julio
- agosto
- septiembre
- octubre
- noviembre
- diciembre

## Ejercicios de Práctica
1. Escribir la fecha de hoy
2. Decir la hora actual
3. Crear un horario semanal
4. Practicar contar dinero
''',
      ),
    ],
  ),
  LanguageCourse(
    id: 'spa_int_1',
    title: 'Español Intermedio',
    description: 'Desarrolla tus habilidades básicas de español con gramática y vocabulario más complejos.',
    level: 'Intermediate',
    language: 'Spanish',
    imageUrl: 'assets/images/spanish_intermediate.jpg',
    lessons: [
      CourseLesson(
        id: 'spa_int_1_1',
        title: 'Tiempos Pasados',
        description: 'Aprende a hablar sobre eventos pasados usando diferentes tiempos verbales.',
        vocabulary: [
          'Verbos regulares',
          'Verbos irregulares',
          'Expresiones de tiempo',
          'Palabras de secuencia'
        ],
        grammarPoints: [
          'Pretérito perfecto simple',
          'Pretérito imperfecto',
          'Pretérito pluscuamperfecto',
          'Usos de "solía" + infinitivo'
        ],
        exercises: [
          'Escribir sobre tus últimas vacaciones',
          'Describir un recuerdo de la infancia',
          'Contar una historia usando diferentes tiempos pasados',
          'Practicar formas verbales irregulares'
        ],
        audioUrl: 'assets/audio/spa_int_1_1.mp3',
        videoUrl: 'assets/video/spa_int_1_1.mp4',
        notes: '''
# Tiempos Pasados

## Pretérito Perfecto Simple
Usado para acciones completadas en el pasado.

### Verbos Regulares
- Añadir terminaciones -é, -aste, -ó, -amos, -asteis, -aron
- Ejemplo: hablar → hablé, hablaste, habló, hablamos, hablasteis, hablaron

### Verbos Irregulares
- Deben memorizarse
- Ejemplo: ir → fui, fuiste, fue, fuimos, fuisteis, fueron

## Pretérito Imperfecto
Usado para acciones en progreso en el pasado.

### Estructura
- Sujeto + era/eras/era/éramos/erais/eran + verbo
- Ejemplo: Yo estudiaba cuando llamaste.

## Pretérito Pluscuamperfecto
Usado para acciones completadas antes de otra acción pasada.

### Estructura
- Sujeto + había + participio pasado
- Ejemplo: Yo había terminado mi tarea antes de la cena.

## Ejercicios de Práctica
1. Escribir una entrada de diario sobre ayer
2. Describir lo que estabas haciendo en momentos específicos
3. Contar una historia usando todos los tiempos pasados
4. Practicar formas verbales irregulares
''',
      ),
      CourseLesson(
        id: 'spa_int_1_2',
        title: 'Condicionales',
        description: 'Aprende a expresar situaciones hipotéticas y sus consecuencias.',
        vocabulary: [
          'Oraciones con "si"',
          'Oraciones de resultado',
          'Verbos modales',
          'Conjunciones'
        ],
        grammarPoints: [
          'Condicional cero',
          'Primer condicional',
          'Segundo condicional',
          'Tercer condicional'
        ],
        exercises: [
          'Crear oraciones condicionales',
          'Jugar roles en situaciones hipotéticas',
          'Escribir sobre tus sueños y deseos',
          'Discutir posibles escenarios futuros'
        ],
        audioUrl: 'assets/audio/spa_int_1_2.mp3',
        videoUrl: 'assets/video/spa_int_1_2.mp4',
        notes: '''
# Condicionales

## Condicional Cero
Usado para verdades generales y hechos.

### Estructura
- Si + presente simple, presente simple
- Ejemplo: Si calientas hielo, se derrite.

## Primer Condicional
Usado para situaciones futuras posibles.

### Estructura
- Si + presente simple, futuro simple
- Ejemplo: Si llueve, me quedaré en casa.

## Segundo Condicional
Usado para situaciones hipotéticas presentes.

### Estructura
- Si + imperfecto de subjuntivo, condicional simple
- Ejemplo: Si tuviera dinero, viajaría.

## Tercer Condicional
Usado para situaciones hipotéticas pasadas.

### Estructura
- Si + pluscuamperfecto de subjuntivo, condicional compuesto
- Ejemplo: Si hubiera estudiado, habría aprobado.

## Ejercicios de Práctica
1. Crear oraciones para cada tipo de condicional
2. Jugar roles en diferentes escenarios
3. Escribir sobre tus sueños y deseos
4. Discutir posibles escenarios futuros
''',
      ),
    ],
  ),
]; 