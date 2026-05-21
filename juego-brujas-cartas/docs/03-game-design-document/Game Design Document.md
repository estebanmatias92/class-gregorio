# Game Design Document

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
