import '../models/language_course.dart';

final List<LanguageCourse> spanishCourses = [
  LanguageCourse(
    id: 'spa_beg_1',
    title: 'Español para Principiantes',
    description:
        'Comienza tu viaje de aprendizaje del español con vocabulario y gramática básicos. Perfecto para principiantes absolutos.',
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
          'Estoy bien, gracias',
          'Adiós'
        ],
        grammarPoints: [
          'Estructura básica de oraciones',
          'Pronombres personales',
          'Presente simple',
          'Formación de preguntas'
        ],
        exercises: [
          'Practicar saludos con diferentes personas',
          'Presentarte a un compañero',
          'Escribir una breve presentación',
          'Role-play de situaciones sociales comunes'
        ],
        audioUrl: 'assets/audio/spa_beg_1_1.mp3',
        videoUrl: 'assets/video/spa_beg_1_1.mp4',
        notes: '''
# Saludos y Presentaciones

## Saludos Básicos
- Hola / Buenos días (antes del mediodía)
- Buenas tardes (mediodía - 6pm)
- Buenas noches (después de las 6pm)

## Presentaciones
1. Comienza con un saludo
2. Di tu nombre: "Me llamo [nombre]" o "Soy [nombre]"
3. Pregunta el nombre de la otra persona: "¿Cómo te llamas?"
4. Responde a su presentación: "Mucho gusto"

## Frases Comunes
- ¿Cómo estás?
- Estoy bien, gracias
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
- AM/PM

## Días de la Semana
- Lunes
- Martes
- Miércoles
- Jueves
- Viernes
- Sábado
- Domingo

## Meses del Año
- Enero
- Febrero
- Marzo
- Abril
- Mayo
- Junio
- Julio
- Agosto
- Septiembre
- Octubre
- Noviembre
- Diciembre

## Ejercicios de Práctica
1. Escribir la fecha de hoy
2. Decir la hora actual
3. Crear un horario semanal
4. Practicar contar dinero
''',
      ),
      CourseLesson(
        id: 'spa_beg_1_3',
        title: 'Actividades Diarias',
        description:
            'Aprende vocabulario y frases para actividades diarias comunes.',
        vocabulary: [
          'Despertarse',
          'Vestirse',
          'Desayunar',
          'Ir al trabajo',
          'Almorzar',
          'Volver a casa',
          'Cenar',
          'Ir a la cama',
          'Ducharse',
          'Cepillarse los dientes'
        ],
        grammarPoints: [
          'Presente simple para rutinas',
          'Expresiones de tiempo',
          'Adverbios de frecuencia',
          'Preguntas sobre rutinas diarias'
        ],
        exercises: [
          'Describir tu rutina diaria',
          'Crear un horario diario',
          'Preguntar sobre las actividades de alguien',
          'Escribir sobre tu día ideal'
        ],
        audioUrl: 'assets/audio/spa_beg_1_3.mp3',
        videoUrl: 'assets/video/spa_beg_1_3.mp4',
        notes: '''
# Actividades Diarias

## Rutinas Comunes
1. Rutina Matutina
   - Despertarse
   - Vestirse
   - Desayunar
   - Ir al trabajo/escuela

2. Actividades de la Tarde
   - Almorzar
   - Trabajar/Estudiar
   - Tomar un descanso
   - Volver a casa

3. Rutina Nocturna
   - Cenar
   - Ver televisión
   - Leer un libro
   - Ir a la cama

## Expresiones de Tiempo
- Por la mañana
- Por la tarde
- Por la noche
- A [hora específica]

## Adverbios de Frecuencia
- Siempre
- Usualmente
- A menudo
- A veces
- Nunca

## Diálogos de Práctica
1. Rutina Matutina:
   A: ¿A qué hora te despiertas?
   B: Me despierto a las 7:00 AM.
   A: ¿Qué haces después de despertarte?
   B: Me ducho y desayuno.

2. Rutina Nocturna:
   A: ¿Qué haces por la noche?
   B: Ceno a las 7:00 PM y veo televisión.
   A: ¿A qué hora te acuestas?
   B: Usualmente me acuesto a las 10:00 PM.
''',
      ),
      CourseLesson(
        id: 'spa_beg_1_4',
        title: 'Comida y Bebidas',
        description:
            'Aprende vocabulario y frases relacionadas con la comida, bebidas y pedidos en restaurantes.',
        vocabulary: [
          'Desayuno',
          'Almuerzo',
          'Cena',
          'Agua',
          'Café',
          'Té',
          'Pan',
          'Arroz',
          'Carne',
          'Verduras',
          'Frutas',
          'Postre'
        ],
        grammarPoints: [
          'Sustantivos contables e incontables',
          'Alguno y ninguno',
          'Gustaría',
          'Pedir comida'
        ],
        exercises: [
          'Crear una lista de compras',
          'Pedir comida en un restaurante',
          'Describir tu comida favorita',
          'Planear un menú para una fiesta'
        ],
        audioUrl: 'assets/audio/spa_beg_1_4.mp3',
        videoUrl: 'assets/video/spa_beg_1_4.mp4',
        notes: '''
# Comida y Bebidas

## Comidas Comunes
1. Desayuno
   - Pan
   - Huevos
   - Cereal
   - Fruta

2. Almuerzo/Cena
   - Arroz
   - Carne
   - Verduras
   - Ensalada

3. Bebidas
   - Agua
   - Café
   - Té
   - Jugo

## Pedir Comida
- Me gustaría...
- ¿Puedo tener...?
- ¿Qué te gustaría?
- ¿Tienes...?

## Contable vs Incontable
Contable:
- Una manzana
- Dos sándwiches
- Tres tazas de café

Incontable:
- Un poco de arroz
- Un poco de agua
- Un poco de pan

## Diálogos de Práctica
1. En un Restaurante:
   A: ¿Qué te gustaría ordenar?
   B: Me gustaría un sándwich y una taza de café.
   A: ¿Te gustaría algo más?
   B: No, gracias.

2. En una Cafetería:
   A: ¿Puedo tener una taza de té, por favor?
   B: ¿Te gustaría leche y azúcar?
   A: Sí, por favor. Y un pedazo de pastel.
''',
      ),
    ],
  ),
  LanguageCourse(
    id: 'spa_int_1',
    title: 'Español Intermedio',
    description:
        'Desarrolla tus habilidades básicas de español con gramática y vocabulario más complejos.',
    level: 'Intermediate',
    language: 'Spanish',
    imageUrl: 'assets/images/spanish_intermediate.jpg',
    lessons: [
      CourseLesson(
        id: 'spa_int_1_1',
        title: 'Tiempos Pasados',
        description:
            'Aprende a hablar sobre eventos pasados usando diferentes tiempos verbales.',
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
          'Usado para + infinitivo'
        ],
        exercises: [
          'Escribir sobre tus últimas vacaciones',
          'Describir un recuerdo de la infancia',
          'Contar una historia usando diferentes tiempos pasados',
          'Practicar formas de verbos irregulares'
        ],
        audioUrl: 'assets/audio/spa_int_1_1.mp3',
        videoUrl: 'assets/video/spa_int_1_1.mp4',
        notes: '''
# Tiempos Pasados

## Pretérito Perfecto Simple
Usado para acciones completadas en el pasado.

### Verbos Regulares
- Añadir -é, -aste, -ó, -amos, -asteis, -aron
- Ejemplo: caminar → caminé, caminaste, caminó

### Verbos Irregulares
- Deben ser memorizados
- Ejemplo: ir → fui, fuiste, fue

## Pretérito Imperfecto
Usado para acciones en progreso en el pasado.

### Estructura
- Sujeto + estaba/estabas + verbo-ing
- Ejemplo: Yo estaba estudiando cuando llamaste.

## Pretérito Pluscuamperfecto
Usado para acciones completadas antes de otra acción pasada.

### Estructura
- Sujeto + había + participio pasado
- Ejemplo: Yo había terminado mi tarea antes de la cena.

## Ejercicios de Práctica
1. Escribir una entrada de diario sobre ayer
2. Describir lo que estabas haciendo en momentos específicos
3. Contar una historia usando todos los tiempos pasados
4. Practicar formas de verbos irregulares
''',
      ),
      CourseLesson(
        id: 'spa_int_1_2',
        title: 'Condicionales',
        description:
            'Aprende a expresar situaciones hipotéticas y sus consecuencias.',
        vocabulary: [
          'Cláusulas si',
          'Cláusulas de resultado',
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
          'Role-play de situaciones hipotéticas',
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
2. Role-play de diferentes escenarios
3. Escribir sobre tus sueños y deseos
4. Discutir posibles escenarios futuros
''',
      ),
    ],
  ),
];
