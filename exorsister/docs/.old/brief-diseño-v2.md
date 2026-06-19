# BRIEF DE DISEÑO: EXORSISTER (V2.0)

## 1. Visión General del Sistema

Exorsister es un RPG táctico por turnos estructurado sobre un bucle temporal determinista.

El jugador no se enfrenta a una generación procedural constante, sino que debe "resolver" una semilla algorítmica estática mediante la exploración iterativa, el ensayo y error, y la optimización de rutas (_routing_). El objetivo principal es trazar el plan óptimo para recolectar recursos, adquirir conocimiento y derrotar al Jefe Final antes de que el medidor de amenaza alcance su límite.

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

- **El Libro:** Es la entidad persistente principal durante los micro-reinicios (Muerte Regular). Permite al jugador documentar coordenadas, debilidades de enemigos, ubicaciones de armas específicas y requisitos de misiones. Funciona como la herramienta de interfaz para que el jugador diseñe su "ruta óptima" en las iteraciones siguientes.
    
- **El Estudio:** Mecánica logística. Al encontrar equipo desconocido, el jugador debe enviarlo por correo consumiendo energía y tiempo (días). Al regresar, las estadísticas, clasificación y habilidades ocultas del objeto se revelan y se registran permanentemente en el Libro para esa semilla.
    

## 4. Progresión de la Amenaza: Jefe Final y Mal del Mundo

El "Mal del Mundo" es una mecánica global ligada a la semilla (ej. Mal Carmesí, Mal de Dinero, Mal de Conocimiento) que altera las reglas de la partida (precios dinámicos, borrado de datos, aparición de enemigos de élite) e influye en la mecánica del Jefe Final.

El límite de tiempo de la partida está dictado por una Barra de Progreso. Esta barra avanza con el paso de los días dentro del juego y con cada Muerte Regular.

- **Invocación Forzada:** Si la barra llega al máximo, el Jefe Final es invocado automáticamente y arrastra al jugador al combate definitivo en su estado de máximo poder.
    
- **Invocación Prematura (Manual):** El jugador puede recolectar objetos específicos e información dispersa en la semilla para ejecutar un ritual e invocar al Jefe Final antes de que la barra se llene, enfrentándolo en un estado más débil.
    

> **[POR DEFINIR: Dinámica de Invocación Manual]**
> 
> - _¿Cuáles son los pasos mecánicos del ritual? ¿Requiere ubicaciones específicas, combinaciones exactas de ítems procedimentales o un consumo masivo de Mente/Energía?_
>     
> - _¿La información del ritual está fragmentada en la biblioteca, en élites o en misiones?_
>     

> **[POR DEFINIR: Escalamiento del Jefe Final]**
> 
> - _¿Cómo se calcula exactamente el poder del Jefe en relación con la barra? ¿Gana multiplicadores de estadísticas crudas, nuevas fases de combate o inmunidades a ciertos tipos de daño a medida que la barra se llena?_
>     

> **[POR DEFINIR: Recompensas y Meta-Progresión]**
> 
> - _Al derrotar al Jefe Final y ganar la partida, ¿qué desbloquea el jugador a nivel de cuenta (Logros, nuevas clases de personajes, nuevos modificadores de semillas, objetos base para futuras partidas)?_
>     

## 5. Entidad Jugador: Atributos y Modificadores

El jugador selecciona un personaje base con estadísticas iniciales:

- **Vida Máxima.**
    
- **Espíritu/Mente:** Recurso para hechizos y segunda barra de salud (el daño recibido al llegar a 0 de Mente se deduce de la Vida).
    
- **Energía Combate:** Límite de acciones tácticas por turno.
    
- **Energía Fuera de Combate:** Límite de acciones de exploración diarias.
    

**Alteraciones del Estado:**

- **Efectos de Estado:** Condicionantes físicos temporales (veneno) o permanentes (pulmón perforado). Volátiles (se pierden en la Muerte Regular). Curables en el hospital.
    
- **Habilidades Pasivas:** Atributos positivos/negativos del personaje (Fuerte, Frágil, Arma Favorita). Volátiles. Al morir de forma regular, el jugador se reinicia con sus pasivas base.
    
- **Maldiciones:** Alteraciones de alto impacto que ofrecen un beneficio y un perjuicio simultáneo. _Persistentes_ a través de Muertes Regulares. Requieren métodos específicos para ser removidas.
    

## 6. Economía, Exploración y Tiempo

El mundo de la ciudad se compone de:

- **La Casa (Hub):** Base de operaciones. Permite dormir (restaura energía, avanza el tiempo), usar objetos, pedir envíos (teléfono), gestionar el correo y ejecutar el ritual.
    
- **Localizaciones Fijas:** Hospital (curación de estados), Tienda (compra de equipo), Biblioteca (investigación de debilidades y hechizos).
    
- **Puntos de Evento (Bosque, Cementerio, Plaza):** Zonas de exploración divididas por "habitaciones" con un límite de búsquedas. Contienen encuentros y objetos fijos según la semilla.
    
- **Descanso Exterior:** Dormir fuera de casa cuesta 1 hora, recupera poca energía y avanza el tiempo, útil para optimizar el _routing_ sin volver a la base.
    

## 7. Inventario y Equipamiento

El equipamiento otorga viabilidad física y mágica sin coste de acciones al ser equipado fuera de combate.

- **Espacios:** Casco, Pechera, 2 Manos (armas) y 8 Anillos (4 por mano).
    
- **Clasificación (0.0 a 5.0):** Sistema numérico que define el poder bruto. Un nivel 5.0 está reservado para _endgame_. Las desventajas y restricciones de un arma aumentan su poder real pero mantienen su clasificación intacta para engañar a jugadores sin conocimiento (requiriendo el Estudio).
    
- **Tipos de Armas:** Básica, Mágica (otorga habilidades sin necesidad de "Hablar"), Maldita (altas estadísticas, alto perjuicio), Sagrada (efectos pasivos fuertes, restricciones rígidas).
    

## 8. Sistema de Combate Táctico

El combate es por turnos asíncronos individuales (1 vs 1). El primer turno siempre pertenece al jugador y finaliza al agotar su Energía de Combate o por decisión propia.

- **Anatomía Dinámica:** Los enemigos carecen de una barra de vida global. Tienen extremidades y puntos débiles independientes. Destruir una parte afecta sus acciones o desencadena su muerte.
    

**Habilidades de Combate:**

- **Físicas:** Dependen del arma equipada. Consumen energía de combate.
    
- **Habilidad Mental (Hablar):** Acción táctica _opcional_. Inyecta una mecánica síncrona (tiempo real). El jugador debe tipear el nombre de un hechizo. El sistema consume acciones en función del tiempo transcurrido (ej. cada 3 segundos = 1 acción de combate). Recompensa la memoria mecánica y penaliza la duda.
    
- **Gestión en Combate:** Utilizar objetos consumibles o cambiar equipamiento durante la pelea consume acciones de combate.
    

> **[POR DEFINIR: Cancelación de la acción 'Hablar']**
> 
> - _Si el jugador inicia la acción de teclear un hechizo pero decide abortar antes de presionar Enter (o nota que va a perder demasiadas acciones), ¿se puede cancelar? ¿Se penaliza con pérdida de energía por el tiempo ya transcurrido en la interfaz?_
>