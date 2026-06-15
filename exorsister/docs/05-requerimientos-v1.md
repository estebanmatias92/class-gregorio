# Documento de Requerimientos — Exorsister v3.0

**Proyecto:** Exorsister  
**Fase:** Análisis (SDLC)  
**Versión:** 1.0  
**Fuente:** Documento de Casos de Uso v1.0 (`casos-de-uso-v1.md`)

---

## 1. Requerimientos Funcionales (RF)

### 1.0 Módulo: Servicio de Semilla (SeedService)

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-66 | El sistema debe exponer un servicio central que, dada una semilla, responda consultas deterministas para cada módulo: ubicación de eventos, estadísticas de objetos, datos de enemigos, misiones diarias, recompensas, tipo de Mal del Mundo y páginas de ritual. | Alta | CU-01 |
| RF-67 | El sistema debe garantizar que, para una misma semilla y los mismos parámetros de consulta (ej. día, ubicación), la respuesta sea siempre idéntica en todas las iteraciones de la partida. | Alta | CU-01 |
| RF-68 | El sistema debe permitir que cada módulo (Inventario, Combate, Exploración, Misiones, Jefe Final) consuma datos de la semilla sin conocer el algoritmo de generación interno. | Media | CU-01 |

### 1.1 Módulo: Gestión de Partida

|  ID   | Requerimiento                                                                                                                                                                                                              | Prioridad | CU origen |
| :---: | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------: | :-------: |
| RF-01 | El sistema debe mostrar un menú principal con las opciones "Nueva Partida" y "Salir" al iniciar el juego.                                                                                                                  |   Alta    |   CU-01   |
| RF-02 | El sistema debe permitir al jugador seleccionar un personaje base con estadísticas iniciales (HP, MP, AP de combate, energía fuera de combate) al iniciar una nueva partida.                                               |   Alta    |   CU-01   |
| RF-03 | El sistema debe permitir al jugador seleccionar cero o más modificadores de dificultad desbloqueados antes de iniciar una partida.                                                                                         |   Alta    |   CU-01   |
| RF-04 | El sistema debe generar una semilla determinista al iniciar una nueva partida, que defina de forma inmutable: ubicación de eventos, recompensas, estadísticas de objetos, enemigos, misiones y variante del Mal del Mundo. |   Alta    |   CU-01   |
| RF-05 | El sistema debe crear la instancia de partida situando al jugador en la Casa, Día 1, con inventario vacío, libro vacío y barra de maldad en 0% (modificadores mediante).                                                   |   Alta    |   CU-01   |
| RF-06 | El sistema debe aplicar los efectos de cada modificador seleccionado al inicio de la partida (ej. 20% de barra prellenada, estadísticas base reducidas).                                                                   |   Media   |   CU-01   |
| RF-07 | El sistema debe detectar cuándo el HP del jugador llega a 0 por causas distintas al Jefe Final y ejecutar el flujo de Muerte Regular.                                                                                      |   Alta    |   CU-15   |
| RF-08 | Al ocurrir una Muerte Regular, el sistema debe purgar: inventario, dinero, misiones activas, efectos de estado y habilidades pasivas no base.                                                                              |   Alta    |   CU-15   |
| RF-09 | Al ocurrir una Muerte Regular, el sistema debe conservar: el Libro con todo el conocimiento registrado y las Maldiciones activas.                                                                                          |   Alta    |   CU-15   |
| RF-10 | Al ocurrir una Muerte Regular, el sistema debe incrementar la barra de maldad y reiniciar al jugador en la Casa, Día 1.                                                                                                    |   Alta    |   CU-15   |
| RF-11 | El sistema debe detectar cuándo el HP del jugador llega a 0 durante el combate contra el Jefe Final y ejecutar el flujo de Muerte Definitiva.                                                                              |   Alta    |   CU-16   |
| RF-12 | Al ocurrir una Muerte Definitiva, el sistema debe destruir toda la instancia de partida (semilla, Libro, inventario, misiones), mostrar pantalla de Game Over y retornar al menú principal.                                |   Alta    |   CU-16   |

### 1.2 Módulo: Exploración y Tiempo

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-13 | El sistema debe permitir al jugador seleccionar una localización en el mapa (Casa, localización fija o punto de evento) para desplazarse, consumiendo energía fuera de combate y avanzando el tiempo de juego. | Alta | CU-02 |
| RF-14 | El sistema debe validar que el jugador tenga energía suficiente antes de ejecutar un desplazamiento; si es insuficiente, debe notificarlo y cancelar la acción. | Alta | CU-02 |
| RF-15 | El sistema debe mostrar el tiempo estimado de viaje al seleccionar un destino. | Baja | CU-02 |
| RF-16 | El sistema debe gestionar el ciclo día/noche: las localizaciones fijas pueden cerrarse según el horario y los enemigos fantasmales aparecen solo de noche. | Media | CU-02, CU-03 |
| RF-17 | El sistema debe permitir al jugador descansar para recuperar energía, con dos modalidades: descanso en Casa (recuperación completa) y descanso exterior (recuperación parcial, cuesta 1 hora). | Alta | CU-08 |
| RF-18 | El sistema debe avanzar la barra de maldad cuando el descanso cruza un cambio de día. | Alta | CU-08 |
| RF-19 | El sistema debe rechazar la acción de descansar si el jugador se encuentra en una localización no permitida. | Media | CU-08 |
| RF-20 | El sistema debe gestionar el tiempo de juego (horas y días) como recurso que progresa con las acciones del jugador, y la barra de maldad debe aumentar con el paso de los días y con cada Muerte Regular. | Alta | CU-02, CU-08, CU-15 |

### 1.3 Módulo: Combate

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-21 | El sistema debe iniciar una Fase de Combate por turnos al entrar en una zona con un enemigo vivo. | Alta | CU-03 |
| RF-22 | El sistema debe mostrar el enemigo con anatomía dinámica (partes/extremidades independientes con HP propio). | Alta | CU-03 |
| RF-23 | El sistema debe asignar el primer turno al jugador. El turno del jugador finaliza cuando agota su AP de combate o por decisión manual. | Alta | CU-03 |
| RF-24 | El sistema debe permitir al jugador realizar durante su turno: ataques físicos (según arma equipada), habilidad mental "Hablar" (CU-04), usar objetos consumibles o cambiar equipamiento, consumiendo AP según la acción. | Alta | CU-03 |
| RF-25 | El sistema debe ejecutar automáticamente el turno del enemigo después del turno del jugador, usando sus habilidades en el orden fijo definido por la semilla. | Alta | CU-03 |
| RF-26 | El sistema debe alternar turnos entre jugador y enemigo hasta que una de las partes sea derrotada o el jugador se retire. | Alta | CU-03 |
| RF-27 | El sistema debe verificar el HP de cada parte del enemigo: al destruir el cuerpo o la cabeza, el enemigo es derrotado y el jugador recibe recompensa. | Alta | CU-03 |
| RF-28 | El sistema debe activar la entrada de texto en tiempo real al seleccionar la acción "Hablar", midiendo el tiempo transcurrido para calcular el consumo de AP (ej. 3 segundos = 1 AP). | Alta | CU-04 |
| RF-29 | El sistema debe verificar que el nombre del hechizo tipeado por el jugador sea correcto (registrado en el Libro o provisto por un arma). | Alta | CU-04 |
| RF-30 | Si el hechizo es correcto, el sistema debe ejecutarlo y consumir MP. Si es incorrecto o no se ingresó nada a tiempo, debe cancelar la acción sin efecto, pero conservando el consumo de AP. | Alta | CU-04 |
| RF-31 | El sistema debe permitir la gestión de inventario (equipar, usar, enviar al Estudio) durante el combate, con la restricción de que cada acción consume AP. | Alta | CU-05 |

### 1.4 Módulo: Inventario y Equipamiento

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-32 | El sistema debe proporcionar al jugador una pantalla de inventario que muestre todos los objetos poseídos (armas, armaduras, anillos, consumibles). | Alta | CU-05 |
| RF-33 | El sistema debe gestionar los espacios de equipamiento: casco, pechera, 2 manos (armas) y 8 anillos (4 por mano). | Alta | CU-05 |
| RF-34 | El sistema debe permitir equipar un objeto seleccionado en un espacio libre correspondiente. Si no hay espacio libre, debe solicitar al jugador reemplazar o descartar un objeto equipado. | Alta | CU-05 |
| RF-35 | El sistema debe aplicar los efectos de un objeto consumible al seleccionar la acción "Usar" desde el inventario. | Alta | CU-05 |
| RF-36 | El sistema debe permitir al jugador enviar un objeto no identificado al Estudio desde el inventario, consumiendo energía y avanzando el tiempo de espera. | Alta | CU-06 |
| RF-37 | El sistema debe notificar al jugador cuándo el objeto enviado al Estudio estará disponible para retirar. | Media | CU-06 |
| RF-38 | Al retirar un objeto del Estudio, el sistema debe revelar sus estadísticas, clasificación (0.0 a 5.0) y habilidades ocultas, y registrar permanentemente la información en el Libro. | Alta | CU-06 |
| RF-39 | El sistema debe rechazar el envío de un objeto ya identificado al Estudio, informando al jugador. | Media | CU-06 |

### 1.5 Módulo: Conocimiento

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-40 | El sistema debe proporcionar un Libro accesible desde cualquier ubicación, que contenga secciones organizadas: coordenadas exploradas, enemigos, objetos identificados, debilidades registradas, requisitos de misiones, páginas de ritual y hechizos. | Alta | CU-07 |
| RF-41 | El sistema debe persistir el contenido del Libro a través de Muertes Regulares. | Alta | CU-07 |
| RF-42 | El sistema debe permitir al jugador escribir anotaciones manuales en el Libro. | Alta | CU-07 |
| RF-43 | El sistema debe registrar automáticamente en el Libro la información recibida del Estudio, de la Biblioteca y las páginas de ritual encontradas. | Alta | CU-06, CU-07, CU-11 |
| RF-44 | El sistema debe garantizar que las páginas de ritual no se repitan (cada página se obtiene una sola vez por semilla) y que al obtenerlas se añadan automáticamente al Libro. | Alta | CU-07 |
| RF-45 | El sistema debe permitir al jugador investigar en la Biblioteca, consumiendo tiempo, para obtener información sobre habilidades de enemigos y hechizos, registrándola automáticamente en el Libro. | Media | CU-11 |

### 1.6 Módulo: Economía y Servicios

| ID | Re querimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-46 | El sistema debe mostrar un catálogo de objetos disponibles en la Tienda con sus precios. | Alta | CU-09 |
| RF-47 | El sistema debe verificar que el jugador tenga dinero suficiente antes de procesar una compra; si es insuficiente, debe notificarlo y cancelar la transacción. | Alta | CU-09 |
| RF-48 | Al comprar un objeto, el sistema debe entregarlo al inventario del jugador y descontar el dinero correspondiente. | Alta | CU-09 |
| RF-49 | El sistema debe listar los efectos de estado activos del jugador con sus costos de curación al visitar el Hospital. | Media | CU-10 |
| RF-50 | El sistema debe permitir al jugador seleccionar uno o más efectos de estado para curar, verificar que tenga dinero suficiente, descontar el dinero y remover los efectos. | Alta | CU-10 |

### 1.7 Módulo: Misiones

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-51 | El sistema debe asignar misiones al jugador al inicio de cada día, según lo definido por la semilla (mismas misiones, mismo orden y momento entre vidas). | Alta | CU-12 |
| RF-52 | El sistema debe mostrar al jugador la información de cada misión: objetivo, ubicación, pistas del tipo de enemigo, recompensa y fecha límite. | Alta | CU-12 |
| RF-53 | El sistema debe detectar automáticamente cuándo el jugador cumple el objetivo de una misión activa. | Alta | CU-13 |
| RF-54 | Al completar una misión, el sistema debe otorgar la recompensa (dinero, objetos, páginas, etc.) y marcar la misión como completada. | Alta | CU-13 |
| RF-55 | Si la fecha límite de una misión expira sin ser completada, el sistema debe marcarla como fallida sin otorgar recompensa. | Media | CU-13 |

### 1.8 Módulo: Jefe Final

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-56 | El sistema debe permitir al jugador invocar al Jefe Final de forma prematura desde la Zona de Rituales, si posee los objetos requeridos y conoce el orden de invocación (información registrada en el Libro). | Alta | CU-14 |
| RF-57 | El sistema debe verificar que los objetos y el orden de invocación sean correctos. Si son incorrectos, la invocación debe fallar (sin consumir objetos o con una penalización definida). | Alta | CU-14 |
| RF-58 | Si al jugador le falta información (páginas/objetos), el sistema debe informar que la invocación no es posible. | Media | CU-14 |
| RF-59 | Al invocar al Jefe Final de forma prematura, el sistema debe escalar sus estadísticas según el porcentaje actual de la barra de maldad (estadísticas base multiplicadas por el porcentaje). | Alta | CU-14 |
| RF-60 | El sistema debe otorgar al Jefe Final buffos adicionales al alcanzar los umbrales de barra de maldad: 20%, 40%, 60%, 80% y 100%, pudiendo incluir nuevas habilidades y aumentos masivos de estadísticas. | Alta | CU-14, CU-17 |
| RF-61 | Cuando la barra de maldad alcanza el 100%, el sistema debe interrumpir la acción actual del jugador e invocar al Jefe Final de forma forzada en su estado de máximo poder (todos los buffos activos), sin importar la localización del jugador. | Alta | CU-17 |
| RF-62 | El combate contra el Jefe Final debe seguir las mismas reglas de la Fase de Combate estándar (CU-03), con la diferencia de que la derrota del jugador desencadena Muerte Definitiva (RF-11). | Alta | CU-14, CU-17 |

### 1.9 Módulo: Maldiciones

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-63 | El sistema debe aplicar el beneficio y perjuicio asociados a una maldición cuando el jugador la adquiere (por objeto, evento o condición). | Alta | CU-18 |
| RF-64 | El sistema debe persistir las maldiciones activas a través de Muertes Regulares (no se purgan en el flujo de Muerte Regular). | Alta | CU-18 |
| RF-65 | El sistema debe permitir al jugador remover una maldición activa mediante el uso de un objeto específico, eliminando tanto el beneficio como el perjuicio. | Alta | CU-18 |

---

## 2. Requerimientos No Funcionales (RNF)

### 2.1 Rendimiento

| ID | Requerimiento | Prioridad |
|:--:|---------------|:---------:|
| RNF-01 | El sistema "Hablar" (CU-04) debe medir y consumir AP en intervalos máximos de 1 segundo para garantizar precisión en tiempo real. | Alta |
| RNF-02 | La generación de semilla y creación de la instancia de partida (mapa, enemigos, eventos) no debe superar los 3 segundos en hardware de referencia. | Alta |
| RNF-03 | El cambio entre pantallas (inventario, libro, mapa) no debe superar los 500 ms. | Media |

### 2.2 Usabilidad

| ID | Requerimiento | Prioridad |
|:--:|---------------|:---------:|
| RNF-04 | El sistema debe proporcionar feedback visual o auditivo inmediato para cada acción del jugador durante el combate (daño recibido/infligido, consumo de AP, ejecución de hechizo). | Alta |
| RNF-05 | La interfaz del Libro debe permitir navegación rápida entre secciones con un máximo de 2 clics/acciones para llegar a cualquier entrada. | Media |
| RNF-06 | Las acciones críticas (invocación del Jefe, uso de objetos consumibles raros, descarte de equipo) deben solicitar confirmación antes de ejecutarse. | Media |
| RNF-07 | El sistema debe mostrar indicadores claros de: energía disponible, hora/día actual, barra de maldad y estado de salud del jugador en todo momento. | Alta |

### 2.3 Fiabilidad

| ID | Requerimiento | Prioridad |
|:--:|---------------|:---------:|
| RNF-08 | La semilla generada debe producir resultados deterministas e idénticos cada vez que se carga la misma instancia de partida (misma semilla = mismo mapa, enemigos, recompensas). | Alta |
| RNF-09 | Tras una Muerte Regular, el sistema debe restaurar el estado del Libro y las Maldiciones exactamente como estaban antes de la muerte, sin pérdida de datos. | Alta |
| RNF-10 | Las páginas de ritual no deben duplicarse bajo ninguna circunstancia dentro de una misma semilla. | Alta |
| RNF-11 | El sistema debe auto-guardar el estado de la partida al: comenzar un nuevo día, completar una misión, obtener una página de ritual y al terminar un combate. | Media |

### 2.4 Mantenibilidad

| ID | Requerimiento | Prioridad |
|:--:|---------------|:---------:|
| RNF-12 | El sistema de modificadores debe ser extensible: agregar un nuevo modificador no debe requerir cambios en la lógica de generación de semilla ni en el flujo base de partida. | Media |
| RNF-13 | La configuración del Mal del Mundo debe estar desacoplada del sistema de combate y exploración, permitiendo añadir nuevas variantes sin modificar código existente. | Media |
| RNF-14 | Los tipos de enemigos (errante, territorial, fantasmal, especial, del mal del mundo) deben definirse mediante datos configurables, no lógica hardcodeada. | Media |

### 2.5 Portabilidad

| ID | Requerimiento | Prioridad |
|:--:|---------------|:---------:|
| RNF-15 | El sistema debe ejecutarse en las siguientes plataformas: [por definir — PC Windows/Linux/Mac y/o consolas y/o web]. | Baja |

---

## 3. Matriz de Trazabilidad

### RF → CU

| RF | CU origen |
|:--:|:---------:|
| RF-01 al RF-06 | CU-01 |
| RF-66 al RF-68 | CU-01 |
| RF-07 al RF-10 | CU-15 |
| RF-11, RF-12 | CU-16 |
| RF-13 al RF-15 | CU-02 |
| RF-16 | CU-02, CU-03 |
| RF-17 al RF-19 | CU-08 |
| RF-20 | CU-02, CU-08, CU-15 |
| RF-21 al RF-27 | CU-03 |
| RF-28 al RF-30 | CU-04 |
| RF-31 | CU-05 |
| RF-32 al RF-35 | CU-05 |
| RF-36 al RF-39 | CU-06 |
| RF-40 al RF-42 | CU-07 |
| RF-43 | CU-06, CU-07, CU-11 |
| RF-44 | CU-07 |
| RF-45 | CU-11 |
| RF-46 al RF-48 | CU-09 |
| RF-49, RF-50 | CU-10 |
| RF-51, RF-52 | CU-12 |
| RF-53 al RF-55 | CU-13 |
| RF-56 al RF-60 | CU-14 |
| RF-61 | CU-17 |
| RF-62 | CU-14, CU-17 |
| RF-63 al RF-65 | CU-18 |

### CU → RF

| CU | RFs |
|:--:|:----|
| CU-01 | RF-01 al RF-06, RF-66 al RF-68 |
| CU-02 | RF-13 al RF-16, RF-20 |
| CU-03 | RF-16, RF-21 al RF-27 |
| CU-04 | RF-28 al RF-30 |
| CU-05 | RF-31 al RF-35 |
| CU-06 | RF-36 al RF-39, RF-43 |
| CU-07 | RF-40 al RF-44 |
| CU-08 | RF-17 al RF-20 |
| CU-09 | RF-46 al RF-48 |
| CU-10 | RF-49, RF-50 |
| CU-11 | RF-43, RF-45 |
| CU-12 | RF-51, RF-52 |
| CU-13 | RF-53 al RF-55 |
| CU-14 | RF-56 al RF-60, RF-62 |
| CU-15 | RF-07 al RF-10, RF-20 |
| CU-16 | RF-11, RF-12 |
| CU-17 | RF-60 al RF-62 |
| CU-18 | RF-63 al RF-65 |

---

*Fin del documento — Requerimientos Exorsister v1.0*
