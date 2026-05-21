# Documento de Casos de Uso — Exorsister v3.0

**Proyecto:** Exorsister  
**Fase:** Análisis (SDLC)  
**Versión:** 1.0  
**Actor principal:** Jugador  
**Actor secundario:** Sistema

---

## CU-01: Iniciar Nueva Partida

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador se encuentra en el menú principal. |
| **Postcondiciones** | Se genera una semilla, se crea una partida activa y el jugador comienza en la Casa (Día 1). |
| **Disparador** | El jugador selecciona "Nueva Partida". |

**Flujo Principal:**

1. El jugador selecciona "Nueva Partida".
2. El jugador elige un personaje base con estadísticas iniciales.
3. El jugador selecciona cero o más modificadores de dificultad.
4. El Sistema genera una semilla determinista.
5. El Sistema crea la instancia de partida: mapa, eventos, enemigos, misiones, recompensas y Mal del Mundo según la semilla.
6. El Sistema sitúa al jugador en la Casa, Día 1, con el inventario vacío, libro vacío y barra de maldad en 0%.

**Flujos Alternativos:**

- **3a.** Si no hay modificadores desbloqueados, se omite el paso de selección.

**Requisitos asociados:** Brief §1, §2, Glossary "Modificadores", "Semilla".

---

## CU-02: Explorar Localización

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador tiene una partida activa y energía fuera de combate suficiente para desplazarse. |
| **Postcondiciones** | El jugador llega a la localización destino. El tiempo avanza. Se consumen puntos de energía. |
| **Disparador** | El jugador selecciona un destino en el mapa. |

**Flujo Principal:**

1. El jugador selecciona una localización (Casa, localización fija o punto de evento) en el mapa.
2. El Sistema verifica que el jugador tenga energía suficiente para el desplazamiento.
3. El Sistema muestra el tiempo estimado de viaje.
4. El Sistema resta la energía y avanza el tiempo correspondiente.
5. El Sistema sitúa al jugador en la localización destino.

**Flujos Alternativos:**

- **2a.** Energía insuficiente: el Sistema notifica al jugador y cancela la exploración.
- **4a.** Durante el desplazamiento el jugador puede encontrarse con un enemigo errante según la semilla y la hora del día, desencadenando el CU-03.

**Requisitos asociados:** Brief §6, Glossary "Exploración / Explorar", "Energía Fuera de Combate", "Horario".

---

## CU-03: Combatir contra Enemigo

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador está en una localización donde hay un enemigo (errante, territorial, fantasmal o especial). El enemigo está vivo. |
| **Postcondiciones** | El combate termina con el jugador victorioso, derrotado (Muerte Regular) o en retirada. |
| **Disparador** | El jugador se encuentra con un enemigo en el mapa o en un punto de evento. |

**Flujo Principal:**

1. El Sistema inicia la Fase de Combate.
2. El Sistema muestra el enemigo con su anatomía dinámica (partes/ extremidades).
3. El turno comienza con el jugador.
4. El jugador gasta Energía de Combate para realizar acciones: ataque físico, habilidad mental (CU-04), usar objeto o cambiar equipamiento.
5. El jugador finaliza su turno manualmente o al agotar su Energía de Combate.
6. El Sistema ejecuta el turno del enemigo (habilidades en orden fijo según semilla, afectando partes específicas del jugador).
7. Se repiten los pasos 3 a 6 hasta que una de las partes es derrotada o el jugador huye.

**Flujos Alternativos:**

- **4a.** El jugador usa un objeto del inventario durante el combate: consume acciones de combate.
- **6a.** Si el jugador llega a 0 HP: Muerte Regular (CU-15) o Muerte Definitiva (CU-16) según el contexto.
- **6b.** Si el HP del enemigo (cuerpo/cabeza) llega a 0: el enemigo es derrotado, el jugador recibe recompensa.

**Requisitos asociados:** Brief §8, Glossary "Fase de Combate", "Turno", "Action Points", "Enemigo", "Anatomía Dinámica".

---

## CU-04: Usar Habilidad Mental "Hablar"

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador está en Fase de Combate (CU-03), conoce el nombre de un hechizo (anotado en el Libro o provisto por un arma), y tiene suficiente MP y AP. |
| **Postcondiciones** | El hechizo se ejecuta o se cancela. Se consume AP según el tiempo real transcurrido. Se consume MP. |
| **Disparador** | El jugador selecciona la acción "Hablar" durante su turno de combate. |

**Flujo Principal:**

1. El jugador selecciona "Hablar".
2. El Sistema activa la entrada de texto en tiempo real y comienza a medir el tiempo transcurrido.
3. El jugador tipea el nombre del hechizo.
4. El jugador presiona Enter.
5. El Sistema verifica que el nombre del hechizo sea correcto.
6. El Sistema consume AP en proporción al tiempo real transcurrido (ej. 3s = 1 AP).
7. Si es correcto: el Sistema ejecuta el hechizo y consume MP.
8. Si es incorrecto o no se ingresó nada a tiempo: el Sistema cancela la acción sin efecto. Los AP consumidos se pierden.

**Flujos Alternativos:**

- **3a.** El jugador no tipea ningún hechizo antes de que se agote el tiempo estipulado: el Sistema finaliza la acción sin efecto y consume los AP.

**Requisitos asociados:** Brief §8 (Habilidad Mental), Glossary "Habilidades Mentales".

---

## CU-05: Gestionar Inventario

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador tiene una partida activa y posee al menos un objeto en el inventario. |
| **Postcondiciones** | El inventario se modifica (equipamiento cambiado, objeto usado o consumido). |
| **Disparador** | El jugador abre la pantalla de inventario. |

**Flujo Principal:**

1. El jugador abre su inventario.
2. El Sistema muestra todos los objetos (armas, armaduras, anillos, consumibles).
3. El jugador selecciona un objeto y una acción:
   - **Equipar:** coloca el objeto en un espacio libre correspondiente (casco, pechera, mano o anillo).
   - **Usar:** aplica el efecto del objeto consumible.
   - **Enviar al Estudio:** deriva al CU-06.
4. El Sistema ejecuta la acción y actualiza el estado del jugador.

**Flujos Alternativos:**

- **3a.** Equipar sin espacio libre: el Sistema solicita reemplazar o descartar un objeto equipado.
- **3b.** Durante el combate (CU-03), cambiar equipamiento o usar objeto consume AP.

**Requisitos asociados:** Brief §7, Glossary "Inventario", "Item", "Sistema de Clasificación", "Armas".

---

## CU-06: Enviar Objeto al Estudio

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador tiene un objeto no identificado en el inventario y energía/tiempo disponible para el envío. |
| **Postcondiciones** | El objeto es enviado. Tras una espera (días), el sistema revela sus estadísticas y las registra en el Libro. El jugador debe retirar el objeto en el Estudio. |
| **Disparador** | El jugador selecciona "Enviar al Estudio" sobre un objeto en el inventario (CU-05). |

**Flujo Principal:**

1. El jugador selecciona "Enviar al Estudio" desde el inventario.
2. El Sistema verifica que el objeto sea identificable (no esté ya registrado).
3. El Sistema consume energía y avanza el tiempo de espera.
4. El Sistema notifica al jugador cuándo estará disponible el resultado.
5. Al regresar al Estudio tras el tiempo de espera, el Sistema muestra las estadísticas, clasificación y habilidades ocultas del objeto.
6. El Sistema registra permanentemente la información en el Libro.

**Flujos Alternativos:**

- **2a.** Objeto ya identificado: el Sistema informa y cancela la acción.

**Requisitos asociados:** Brief §3, Glossary "Estudio".

---

## CU-07: Consultar el Libro

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador tiene una partida activa. El Libro contiene al menos una entrada. |
| **Postcondiciones** | El jugador visualiza la información registrada. |
| **Disparador** | El jugador abre el Libro desde cualquier ubicación. |

**Flujo Principal:**

1. El jugador abre el Libro.
2. El Sistema muestra las secciones disponibles: coordenadas exploradas, enemigos, objetos identificados, debilidades registradas, requisitos de misiones, páginas de ritual y hechizos.
3. El jugador navega y lee la información.
4. Opcionalmente, el jugador escribe anotaciones manuales.
5. El jugador cierra el Libro.

**Requisitos asociados:** Brief §3, Glossary "Libro", "Páginas".

---

## CU-08: Descansar

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador está en la Casa o en un punto de evento con capacidad de descanso exterior. Tiene energía por debajo del máximo. |
| **Postcondiciones** | El jugador recupera energía. El tiempo avanza. La barra de maldad aumenta en función de los días transcurridos. |
| **Disparador** | El jugador selecciona la acción de descansar. |

**Flujo Principal:**

1. El jugador selecciona descansar.
2. El Jugador elige la duración del descanso.
3. El Sistema verifica que sea posible (Casa o descanso exterior).
4. El Sistema restaura energía y avanza el tiempo.
5. Si la duración cruza un cambio de día, el Sistema actualiza la barra de maldad.

**Flujos Alternativos:**

- **2a.** Descanso en Casa: recuperación completa de energía.
- **2b.** Descanso Exterior: recupera poca energía, cuesta 1 hora de tiempo.
- **3a.** Si el jugador intenta descansar en una localización no permitida, el Sistema rechaza la acción.

**Requisitos asociados:** Brief §6, Glossary "Casa (Hub)", "Descanso Exterior", "Energía Fuera de Combate", "Tiempo".

---

## CU-09: Comprar en Tienda

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador está en la localización Tienda. Tiene dinero suficiente. |
| **Postcondiciones** | El jugador recibe el objeto comprado. Su dinero disminuye. |
| **Disparador** | El jugador selecciona un objeto de la tienda para comprar. |

**Flujo Principal:**

1. El Sistema muestra el catálogo de la tienda con precios.
2. El jugador selecciona un objeto disponible.
3. El Sistema verifica que el jugador tenga dinero suficiente.
4. El Sistema entrega el objeto al inventario del jugador y descuenta el dinero.
5. El Sistema actualiza el inventario visible.

**Flujos Alternativos:**

- **3a.** Dinero insuficiente: el Sistema notifica al jugador y cancela la compra.
- **3b.** Mal del Mundo de Dinero activo: los precios pueden estar alterados.

**Requisitos asociados:** Brief §6, Glossary "Localizaciones Fijas", "Mal del Mundo".

---

## CU-10: Curarse en el Hospital

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador está en la localización Hospital. Tiene dinero y efectos de estado curables. |
| **Postcondiciones** | Los efectos de estado seleccionados son removidos. El dinero disminuye. |
| **Disparador** | El jugador selecciona el servicio de curación en el Hospital. |

**Flujo Principal:**

1. El Sistema lista los efectos de estado activos del jugador y sus costos de curación.
2. El jugador selecciona el/los efecto(s) a curar.
3. El Sistema verifica que el jugador tenga dinero suficiente.
4. El Sistema descuenta el dinero y remueve los efectos.
5. El Sistema confirma la curación.

**Flujos Alternativos:**

- **3a.** Dinero insuficiente: el Sistema notifica y cancela la curación.

**Requisitos asociados:** Brief §6, Glossary "Efectos de Estado".

---

## CU-11: Investigar en la Biblioteca

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador está en la localización Biblioteca. |
| **Postcondiciones** | El jugador obtiene información sobre habilidades o hechizos y la registra en el Libro. |
| **Disparador** | El jugador selecciona la acción de investigar en la Biblioteca. |

**Flujo Principal:**

1. El Sistema muestra las opciones de investigación disponibles (habilidades de enemigos, hechizos, etc.).
2. El jugador selecciona un tema a investigar.
3. El Sistema consume tiempo (avanza el horario).
4. El Sistema revela la información solicitada y la registra automáticamente en el Libro.

**Requisitos asociados:** Brief §6 (Biblioteca: "investigación de habilidades y hechizos"), Glossary "Localizaciones Fijas".

---

## CU-12: Recibir Misión Diaria

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Sistema |
| **Precondiciones** | El jugador comienza un nuevo día en la Casa. |
| **Postcondiciones** | Una o más misiones son asignadas al jugador con un límite de tiempo. |
| **Disparador** | El sistema avanza a un nuevo día. |

**Flujo Principal:**

1. Al inicio de cada día, el Sistema consulta la semilla para determinar la(s) misión(es) del día.
2. El Sistema asigna la(s) misión(es) al jugador.
3. El Sistema muestra la información disponible: objetivo, ubicación, pistas del tipo de enemigo, recompensa y fecha límite.

**Flujos Alternativos:**

- **1a.** Si no hay misiones asignadas para ese día según la semilla, el Sistema no asigna ninguna.

**Requisitos asociados:** Glossary "Misión", "Recompensa".

---

## CU-13: Completar Misión

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador tiene una misión activa. |
| **Postcondiciones** | La misión se marca como completada. El jugador recibe la recompensa. |
| **Disparador** | El jugador cumple el objetivo de la misión (ej. derrota a un enemigo específico en la ubicación indicada). |

**Flujo Principal:**

1. El jugador ejecuta las acciones necesarias para cumplir el objetivo de la misión.
2. El Sistema detecta que la condición de éxito se ha alcanzado.
3. El Sistema otorga la recompensa (dinero, objetos, páginas, etc.).
4. El Sistema marca la misión como completada.

**Flujos Alternativos:**

- **1a.** Si la fecha límite expira antes de completar la misión, el Sistema la marca como fallida sin recompensa.

**Requisitos asociados:** Glossary "Misión", "Recompensa".

---

## CU-14: Invocar al Jefe Final (Invocación Prematura)

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador está en la Zona de Rituales. Posee los objetos requeridos y conoce el orden de invocación (información registrada en el Libro). |
| **Postcondiciones** | El Jefe Final es invocado en estado debilitado (proporcional a la barra de maldad). Comienza la Fase de Combate (CU-03). |
| **Disparador** | El jugador selecciona la acción de invocar en la Zona de Rituales. |

**Flujo Principal:**

1. El jugador accede a la Zona de Rituales.
2. El jugador selecciona los objetos requeridos en el orden correcto.
3. El Sistema verifica que los objetos sean los correctos y el orden sea el adecuado.
4. El Sistema ejecuta la invocación.
5. El Jefe Final aparece con estadísticas escaladas según el porcentaje actual de la barra de maldad.
6. Comienza la Fase de Combate (CU-03, ampliado para Jefe Final).

**Flujos Alternativos:**

- **3a.** Objetos incorrectos u orden incorrecto: la invocación falla. No se consumen los objetos (o se define otra penalización).
- **3b.** Información incompleta: el Sistema informa que faltan páginas/objetos.

**Requisitos asociados:** Brief §4, Glossary "Invocación Prematura", "Jefe Final", "Zona de Rituales", "Nivel de Maldad".

---

## CU-15: Sufrir Muerte Regular

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Sistema |
| **Precondiciones** | El jugador está en una partida activa. Su HP llega a 0 por cualquier causa que NO sea el Jefe Final. |
| **Postcondiciones** | El jugador reinicia en la Casa, Día 1, con el Libro y Maldiciones intactos. Inventario, dinero, misiones activas, efectos de estado y habilidades pasivas se purgan. La barra de maldad aumenta. |
| **Disparador** | HP del jugador llega a 0 (combate contra enemigo no-jefe, evento, etc.). |

**Flujo Principal:**

1. El HP del jugador llega a 0.
2. El Sistema determina que la causa no es el Jefe Final.
3. El Sistema purga: inventario, dinero, misiones activas, efectos de estado y habilidades pasivas no base.
4. El Sistema conserva: Libro (con todo el conocimiento registrado) y Maldiciones.
5. El Sistema incrementa la barra de maldad.
6. El Sistema reinicia al jugador en la Casa, Día 1.

**Requisitos asociados:** Brief §2, Glossary "Muerte Regular".

---

## CU-16: Sufrir Muerte Definitiva

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Sistema |
| **Precondiciones** | El jugador está en Fase de Combate contra el Jefe Final. Su HP llega a 0. |
| **Postcondiciones** | La partida actual es destruida. El jugador retorna al menú principal. |
| **Disparador** | HP del jugador llega a 0 durante el combate contra el Jefe Final. |

**Flujo Principal:**

1. El HP del jugador llega a 0 durante el combate contra el Jefe Final.
2. El Sistema destruye toda la instancia de partida: semilla, Libro, inventario, misiones.
3. El Sistema muestra pantalla de Game Over.
4. El Sistema retorna al menú principal.

**Requisitos asociados:** Brief §2, Glossary "Muerte Definitiva".

---

## CU-17: Invocación Forzada del Jefe Final

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Sistema |
| **Precondiciones** | La barra de maldad alcanza el 100%. |
| **Postcondiciones** | El Jefe Final aparece en su estado de máximo poder. Comienza la Fase de Combate (CU-03). |
| **Disparador** | La barra de maldad llega a 100% por avance de días o muertes regulares. |

**Flujo Principal:**

1. La barra de maldad alcanza el 100%.
2. El Sistema interrumpe la acción actual del jugador.
3. El Sistema invoca al Jefe Final instantáneamente, sin importar la localización del jugador.
4. El Jefe Final aparece con estadísticas al 100% de poder (con todos los buffos por umbral activos).
5. Comienza la Fase de Combate (CU-03).

**Requisitos asociados:** Brief §4, Glossary "Invocación Forzada", "Nivel de Maldad".

---

## CU-18: Gestionar Maldiciones

| Campo | Valor |
|-------|-------|
| **Actor(es)** | Jugador, Sistema |
| **Precondiciones** | El jugador tiene una maldición activa o posee un objeto que la otorga. |
| **Postcondiciones** | La maldición es adquirida o removida según la acción del jugador. |
| **Disparador** | El jugador adquiere un objeto maldito, cumple una condición que otorga una maldición, o usa un objeto para removerla. |

**Flujo Principal:**

1. **Adquirir:** El jugador obtiene una maldición (por objeto, evento o condición). El Sistema aplica el beneficio y perjuicio asociados.
2. **Remover:** El jugador usa un objeto específico para eliminar una maldición activa. El Sistema remueve tanto el beneficio como el perjuicio.

**Flujos Alternativos:**

- **1a.** La maldición persiste a través de Muertes Regulares (no se purga en CU-15).

**Requisitos asociados:** Brief §5, Glossary "Maldiciones".

---

## Matriz de Trazabilidad

| Caso de Uso | Brief § | Glosario |
|-------------|---------|----------|
| CU-01 | §1, §2 | Modificadores, Semilla |
| CU-02 | §6 | Exploración, Energía Fuera de Combate, Horario |
| CU-03 | §8 | Fase de Combate, Turno, Action Points, Enemigo |
| CU-04 | §8 | Habilidades Mentales |
| CU-05 | §7 | Inventario, Item, Sistema de Clasificación, Armas |
| CU-06 | §3 | Estudio |
| CU-07 | §3 | Libro, Páginas |
| CU-08 | §6 | Casa (Hub), Descanso Exterior, Energía, Tiempo |
| CU-09 | §6 | Localizaciones Fijas, Mal del Mundo |
| CU-10 | §6 | Efectos de Estado |
| CU-11 | §6 | Localizaciones Fijas |
| CU-12 | — | Misión, Recompensa |
| CU-13 | — | Misión, Recompensa |
| CU-14 | §4 | Invocación Prematura, Jefe Final, Zona de Rituales |
| CU-15 | §2 | Muerte Regular |
| CU-16 | §2 | Muerte Definitiva |
| CU-17 | §4 | Invocación Forzada, Nivel de Maldad |
| CU-18 | §5 | Maldiciones |

---

*Fin del documento — Casos de Uso Exorsister v1.0*
