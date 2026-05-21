# Especificaciones Tecnicas del Juegos

## Fase 1: Comprensión General y Planificación del Ciclo de Vida

Basándome en los conceptos generales de ingeniería de software y el ciclo de desarrollo de una solución informática, las principales fases a considerar para el desarrollo de tu juego y lo que implica cada una son las siguientes:

### Análisis de Requisitos

En esta fase, se recopilan y definen detalladamente todas las características y funcionalidades que debe tener el juego. Esto incluye:

- La mecánica del juego (Bossrush, juego de cartas, por turnos).
- Las reglas básicas de juego (mazos de 12 cartas, descarte y robo de cartas, elección simultánea de cartas).
- El ciclo de juego (enfrentamiento con enemigos, recompensas).
- Los tipos de cartas y sus mecánicas (ataque, defensa, magia, velocidad, ventaja).
- Las interacciones entre las cartas (ataques cuerpo a cuerpo, ataques a distancia, defensas, magia).
- Se identificarán los 8 enemigos, su dificultad y la inteligencia artificial asociada.

### Diseño

Aquí se crea la arquitectura del juego. Se definen:

- Las estructuras de datos para las cartas (poder, efectos adicionales), el mazo, el cementerio y la mano de cada jugador.
- Los algoritmos para la lógica del turno (descartar, robar, elegir carta, activar efectos), la comparación de cartas y la aplicación de daño.
- Se detallará cómo se gestiona la ventaja y cómo se actualizan los mazos de los enemigos.
- Se establecerá la interfaz de usuario para la selección de enemigos y el cambio de cartas.

### Implementación

En esta fase se traduce el diseño a código. Se programan:

- Las reglas del juego.
- La inteligencia artificial de los enemigos.
- Los efectos de cada tipo de carta y sus interacciones.
- Se desarrollan los módulos para el manejo de las cartas, los mazos, el seguimiento de la vida del jugador y los enemigos, y la gestión de la ventaja.
- Se implementa la lógica para la progresión del juego, incluyendo la recompensa por derrotar enemigos y el aumento de dificultad.

### Pruebas

Se verifica que el juego funcione según lo esperado y que no haya errores. Esto implica probar:

- Todas las mecánicas, desde las reglas básicas de juego hasta las interacciones complejas entre cartas y los efectos específicos.
- Se realizarán pruebas de unidad para cada componente, pruebas de integración para asegurar que los módulos funcionan correctamente juntos, y pruebas de sistema para validar el juego completo.
- Se simularán diferentes escenarios de combate y el comportamiento de la inteligencia artificial.

### Despliegue

Una vez que el juego ha sido probado y se considera estable, se lanza al público. Esto puede implicar la distribución en plataformas de juegos o la configuración de servidores si es un juego en línea, aunque por la descripción parece ser un juego local.

### Mantenimiento y Evolución

Después del lanzamiento, se corrigen errores que puedan surgir, se realizan actualizaciones y mejoras, y se pueden añadir nuevas características o ajustar las existentes. Esto podría incluir la adición de nuevas cartas o la modificación de la dificultad de los enemigos.


## Fase 2: Entendimiento del Problema y Especificación de Requerimientos - (GDD - Primera Versión)

Con la información recopilada, un Game Design Document (GDD) para tu juego de brujas debería estructurarse de la siguiente manera para capturar todas las especificaciones y requerimientos necesarios:

### Visión General del Juego (Game Overview)

- **Concepto Central**: Resumen conciso del juego. Por ejemplo: Juego de cartas por turnos tipo Bossrush donde el jugador se enfrenta a 8 enemigos, cada uno tan fuerte como el jugador y con IA desafiante.
- **Género**: Bossrush, juego de cartas, por turnos.
- **Plataformas Objetivo**: (Por ejemplo, PC, móvil, etc., según lo definido en los requerimientos no funcionales).
- **Público Objetivo**: A quién está dirigido el juego.

### 3. Mecánicas de Juego (Gameplay Mechanics)

#### Reglas Básicas del Combate

- Mazo de 12 cartas por jugador, una única por personaje, siempre 12 cartas.
- Los jugadores pueden revisar su mazo y cementerio, pero no la mano del rival.
- Descarte de mano y robo de 3 cartas al inicio del turno; barajar descartes si no hay cartas para robar.
- Elección simultánea de una carta sin conocimiento del oponente.
- Activación simultánea de las dos cartas.
- Comparación de cartas y activación de efectos.
- Pérdida del combate al llegar a 0 de vida.

#### Sistema de Ventaja

- El jugador que inflige daño obtiene la Ventaja.
- El jugador con Ventaja activa primero los efectos de cartas con la misma velocidad.
- La Ventaja cambia al principio del turno al primer jugador que hizo daño el turno anterior.

#### Tipos de Cartas y Velocidades

- Ataques Cuerpo a Cuerpo (Velocidad = 1).
- Ataques a Distancia (Velocidad = 2).
- Defensa (Velocidad = 3).
- Magia (Velocidad = 3).
- Explicación de la jerarquía de velocidad y la influencia de la ventaja en empates de velocidad.

#### Interacciones entre Cartas

- **Ataques Cuerpo a Cuerpo vs. Ataques Cuerpo a Cuerpo**: Activación de efectos, comparación de poder, daño completo solo del ganador, activación de efectos al hacer daño. (Ejemplos como CartaPrueba1 y CartaPrueba2 deben detallarse aquí).
- **Ataques a Distancia vs. Ataques a Distancia**: Activación de efecto inicial, daño entre sí, activación de efectos al golpear. (Ejemplos como CartaPrueba3 y CartaPrueba4 deben detallarse aquí, incluyendo el orden de prioridad con ventaja y sin ella).
- **Ataques a Distancia vs. Ataques Cuerpo a Cuerpo**: Prioridad de activación del ataque a distancia (efecto inicial, daño, efecto al golpear) antes que el ataque cuerpo a cuerpo, sin importar la ventaja.
- **Defensas**: Poder de la defensa, activación de efecto inicial, reducción del daño de ataques, efectos "al bloquear" (solo si se bloquea todo el daño). (Ejemplos como CartaPrueba5 y CartaPrueba6 deben detallarse aquí).
- **Magia**: Efectos independientes, prioridad sobre ataques, dependencia de la ventaja contra defensas, negación de cartas/efectos/daño. (Ejemplos como CartaPrueba7 y CartaPrueba8 deben detallarse aquí).

#### Coste de Cartas

- Las cartas no tienen coste a menos que la carta lo especifique.

### Flujo del Juego (Game Flow/Gameplay Loop)

#### Ciclo Principal

- El jugador elige entre 2 de 8 enemigos para enfrentarse.
- Al derrotar a un enemigo, se gana una recompensa.
- Al perder la batalla, se pierde la "run".
- Los mazos de los enemigos se vuelven más fuertes conforme se avanza.

#### Recompensas

- Poder cambiar hasta 2 cartas de tu mazo con el del enemigo.
- Las cartas cambiadas se guardan para cambiarlas en cualquier momento.

#### Enemigos

- Detalles sobre los 8 enemigos, cómo se seleccionan los dos a ofrecer, y cómo el no elegido reaparece "más fuerte".

### Personajes y Progresión

#### Jugador

- Detalles del personaje del jugador, su carta única inicial.

#### Enemigos

- Descripción de cada uno de los 8 enemigos, sus mazos iniciales, y cómo su dificultad escala. (Se requiere más detalle aquí: ¿tienen cartas únicas? ¿qué arquetipos de mazos representan?)

#### Progresión del Jugador

- Cómo la colección de cartas del jugador crece y se adapta.

### Diseño de Interfaz de Usuario (UI Design)

- Elementos en pantalla durante el combate (vida de los jugadores, mano de cartas, mazo, cementerio, indicador de ventaja).
- Pantallas de selección de enemigo.
- Pantallas de gestión de mazo y recompensa.

### Arte y Estilo (Art and Style)

- Dirección de arte general (por ejemplo, estilo de brujas, ambiente).
- Estilo visual de las cartas y sus ilustraciones.
- Efectos visuales para activaciones de cartas, daño, etc.

### Sonido y Música (Sound and Music)

- Música ambiental para el menú y el combate.
- Efectos de sonido para jugar cartas, activar efectos, infligir daño, etc.

### Requerimientos Técnicos (Technical Requirements)

- Plataformas objetivo (especificaciones mínimas y recomendadas de hardware).
- Motor de juego a utilizar (si ya se ha decidido).
- Requisitos de almacenamiento.
- Consideraciones de rendimiento (FPS objetivo, tiempos de carga).
- Manejo de estados del juego (guardado y carga de progreso).

### Requerimientos No Funcionales

- **Usabilidad**: Facilidad de aprendizaje, interfaz intuitiva, tutoriales.
- **Fiabilidad**: Manejo de errores, estabilidad del juego.
- **Escalabilidad**: Facilidad para añadir nuevas cartas, enemigos, o mecánicas en el futuro.
- **Seguridad**: Prevención de trampas, integridad de datos (si aplica).
- **Portabilidad**: (Si el juego se planea para múltiples plataformas).

### Nivel de Detalle

- Inicialmente, este GDD debe ser lo suficientemente detallado como para que un equipo de diseño y desarrollo pueda entender el concepto completo del juego y comenzar a crear prototipos y elementos de arte.
- Las secciones de "Mecánicas de Juego" y "Flujo del Juego" deben ser las más exhaustivas, explicando cada regla y cómo interactúan los elementos.
- Las secciones de arte, sonido y requerimientos técnicos pueden ser menos detalladas al principio, proporcionando una visión general que luego se expandirá en documentos más específicos.
