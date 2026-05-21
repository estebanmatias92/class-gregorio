# BRIEF DE DISEÑO: EXORSISTER (V3.0)

## 1. Visión General del Sistema

Exorsister es un RPG táctico por turnos estructurado sobre un bucle temporal determinista.

El jugador no se enfrenta a una generación procedural constante, sino que debe "resolver" una semilla algorítmica estática mediante la exploración iterativa, el ensayo y el error, y la optimización de rutas (_routing_). El objetivo principal es trazar el plan óptimo para recolectar recursos, adquirir conocimiento y derrotar al Jefe Final antes de que el medidor de amenaza alcance su límite.

## 2. Máquina de Estados y Ciclo de Partida (El Bucle Temporal)

Al iniciar una nueva partida desde cero, el sistema genera una **Semilla** que determina de forma inmutable la ubicación de todos los eventos, recompensas, estadísticas de objetos generados, enemigos y la variante del "Mal del Mundo". El ciclo de vida del jugador se rige por dos invariantes de estado final:

- **Muerte Regular:** Ocurre cuando la vida del jugador llega a cero por cualquier entidad o evento que NO sea el Jefe Final.
    - _Efecto:_ El jugador retorna al Día 1 en su Casa. La semilla se mantiene intacta.
    - _Pérdida:_ Se purga el inventario, dinero, misiones activas, efectos de estado y habilidades pasivas.
    - _Conservación:_ El jugador conserva el Libro (y todo su conocimiento registrado) y las Maldiciones.
    - _Penalización:_ Incremento directo en el medidor de invocación del Jefe Final.

- **Muerte Definitiva:** Ocurre EXCLUSIVAMENTE cuando la vida del jugador llega a cero durante el combate contra el Jefe Final.
    - _Efecto:_ Fin absoluto de la partida (_Game Over_).
    - _Pérdida:_ Destrucción total de la instancia de la partida actual. Se purga el Libro, el inventario, y se descarta la semilla.
    - _Resolución:_ Retorno al menú principal para iniciar una partida completamente nueva.

## 3. Gestión del Conocimiento: El Libro y el Estudio

El progreso real del jugador no radica en la acumulación pasiva de niveles, sino en el mapeo de la semilla.

- **El Libro:** Es la entidad persistente principal durante los micro-reinicios (Muerte Regular). Permite al jugador documentar coordenadas, debilidades de enemigos, ubicaciones de armas específicas y requisitos de misiones. Funciona como la herramienta de interfaz para que el jugador diseñe su "ruta óptima" en las iteraciones siguientes. El Libro también guardará automáticamente la información recibida del Estudio.

- **El Estudio:** Mecánica logística. Al encontrar equipo desconocido, el jugador debe enviarlo por correo consumiendo energía y tiempo (días). Al regresar, las estadísticas, clasificación y habilidades ocultas del objeto se revelan y se registran permanentemente en el Libro para esa semilla.

## 4. Progresión de la Amenaza: Jefe Final y Mal del Mundo

El "Mal del Mundo" es una mecánica global ligada a la semilla (ej. Mal Carmesí, Mal de Dinero, Mal de Conocimiento) que altera las reglas de la partida (precios dinámicos, borrado de datos, aparición de enemigos de élite) e influye en la mecánica del Jefe Final.

El límite de tiempo de la partida está dictado por una Barra de Progreso. Esta barra avanza con el paso de los días dentro del juego y con cada Muerte Regular.

- **Invocación Forzada:** Si la barra llega al máximo, el Jefe Final es invocado automáticamente y arrastra al jugador al combate definitivo en su estado de máximo poder.

- **Invocación Prematura (Manual):** El jugador puede recolectar objetos específicos e información dispersa en la semilla para ejecutar un ritual e invocar al Jefe Final antes de que la barra se llene, enfrentándolo en un estado más débil.

### Dinámica de Invocación Manual

Para invocar al Jefe Final, se requiere utilizar ciertos objetos en un punto específico del mapa (denominado provisionalmente "Zona de Rituales"), donde, al ofrecerlos en el orden correcto, se ejecutará la invocación.

Los objetos serán elegidos aleatoriamente (de una _pool_ de objetos) y podrán ser comprados, pedidos mediante el Estudio (lo cual tomará tiempo), obtenidos como recompensa de combates o encontrados durante la exploración del mapa.

La información del ritual estará fragmentada en páginas que se obtendrán como recompensa de misiones, exploración o al eliminar enemigos específicos.

Para evitar que el jugador pierda demasiado tiempo, estas páginas no se repetirán y se añadirán automáticamente al Libro. Además, el jugador recibirá pistas sobre la ubicación de cada página (por ejemplo, en forma de cartas).

### Escalamiento del Jefe Final

El poder del Jefe Final dependerá del progreso total de la barra en el momento de su invocación.

Este recibirá un aumento de estadísticas proporcional al porcentaje de la barra (las estadísticas base se multiplicarán por dicho porcentaje). A su vez, al alcanzar ciertos umbrales (20%, 40%, 60%, 80% y 100%), el Jefe recibirá mejoras significativas (_buffos_), que pueden incluir nuevas habilidades y aumentos masivos de estadísticas.

### Recompensas y Meta-Progresión

Ganar una partida le permitirá al jugador desbloquear nuevas dificultades para su juego.

En este caso, en lugar de ser dificultades planas, consistirán en modificadores que el jugador podrá seleccionar para personalizar su partida.

- **Modificador 1:** El jugador empieza la partida con un 20% del Mal del Mundo lleno.
- **Modificador 2:** El jugador comienza la partida con menores estadísticas base.
- **Modificador 3:** Morir aumenta en mayor medida el Mal del Mundo.
- **Modificador 4:** El jugador recibe peores recompensas.

Esto permite al jugador personalizar la dificultad de su partida, añadiendo retos a medida que avanza. En el futuro se añadirán otro tipo de recompensas (nuevos enemigos, nuevas zonas, o quizás nuevas campañas con mapas y enemigos distintos).

## 5. Entidad Jugador: Atributos y Modificadores

El jugador selecciona un personaje base con estadísticas iniciales.

- **Vida Máxima:** Salud principal del personaje.
- **Espíritu/Mente:** Recurso para hechizos y segunda barra de salud (el daño recibido al llegar a 0 de Mente se deduce de la Vida).
- **Energía Combate:** Límite de acciones tácticas por turno.
- **Energía Fuera de Combate:** Límite de acciones de exploración diarias.

**Alteraciones del Estado:**

- **Efectos de Estado:** Condicionantes físicos temporales (veneno) o permanentes (pulmón perforado). Volátiles (se pierden en la Muerte Regular). Curables en el hospital o mediante el uso de objetos.
- **Habilidades Pasivas:** Atributos positivos/negativos del personaje (Fuerte, Frágil, Arma Favorita). Volátiles. Al morir de forma regular, el jugador se reinicia con sus pasivas base.
- **Maldiciones:** Alteraciones de alto impacto que ofrecen un beneficio y un perjuicio simultáneo. Persistentes a través de Muertes Regulares. Requieren métodos específicos para ser removidas.

## 6. Economía, Exploración y Tiempo

El mundo de la ciudad se compone de:

- **La Casa (Hub):** Base de operaciones. Permite dormir (restaura energía, avanza el tiempo), usar objetos, pedir envíos (teléfono), gestionar el correo y ejecutar el ritual.
- **Localizaciones Fijas:** Hospital (curación de estados), Tienda (compra de equipo), Biblioteca (investigación de habilidades y hechizos).
- **Puntos de Evento (Bosque, Cementerio, Plaza):** Zonas de exploración divididas por “habitaciones” con un límite de búsquedas. Contienen encuentros y objetos fijos según la semilla.
- **Descanso Exterior:** Dormir fuera de casa cuesta 1 hora, recupera poca energía y avanza el tiempo, útil para optimizar el _routing_ sin volver a la base.

## 7. Inventario y Equipamiento

El equipamiento otorga viabilidad física y mágica sin coste de acciones al ser equipado fuera de combate.

- **Espacios:** Casco, Pechera, 2 Manos (armas) y 8 Anillos (4 por mano).
- **Clasificación (0.0 a 5.0):** Sistema numérico que define el poder bruto. Un nivel 5.0 está reservado para _endgame_. Las desventajas y restricciones de un arma aumentan su poder real pero mantienen su clasificación intacta para engañar a jugadores sin conocimiento (requiriendo el Estudio).
- **Tipos de Armas:** Básica, Mágica (otorga habilidades sin necesidad de “Hablar”), Maldita (altas estadísticas, alto perjuicio), Sagrada (efectos pasivos fuertes, restricciones rígidas).

## 8. Sistema de Combate Táctico

El combate es por turnos asíncronos individuales (1 vs 1). El primer turno siempre pertenece al jugador y finaliza al agotar su Energía de Combate o por decisión propia.

- **Anatomía Dinámica:** Los enemigos carecen de una barra de vida global. Tienen extremidades y puntos débiles independientes. Destruir una parte afecta sus acciones o desencadena su muerte.

**Habilidades de Combate:**

- **Físicas:** Dependen del arma equipada. Consumen energía de combate.
- **Habilidad Mental (Hablar):** Acción táctica opcional. Inyecta una mecánica síncrona (tiempo real). El jugador debe tipear el nombre de un hechizo. El sistema consume acciones en función del tiempo transcurrido (ej. cada 3 segundos = 1 acción de combate). Recompensa la memoria mecánica y penaliza la duda. La acción de hablar termina cuando el jugador presiona _Enter_ o cuando se agota el tiempo estipulado (quedándose sin acciones). Si el jugador no tipea ningún hechizo correctamente antes del límite, perderá la energía utilizada sin obtener ningún efecto.
- **Gestión en Combate:** Utilizar objetos consumibles o cambiar equipamiento durante la pelea consume acciones de combate.
