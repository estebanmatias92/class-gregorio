# Propuesta: Módulo Servicio de Semilla (SeedService)

**Contexto:** Sugerencia surgida durante la revisión de `docs/requerimientos-v1.md`.  
**Audiencia:** Stakeholder — evaluar si implementar esta arquitectura o distribuir la lógica de semilla en cada módulo.

---

## 1. Problema Detectado

La semilla aparece en `docs/casos-de-uso-v1.md` (CU-01) y en `docs/requerimientos-v1.md` (RF-04) como un concepto que el sistema genera, pero **no hay requerimientos que definan cómo el resto de los módulos acceden a los datos deterministas que la semilla produce**.

Actualmente, cada módulo que necesita datos de la semilla (Combate, Misiones, Exploración, Jefe Final) debería implementar su propia lógica de consulta, duplicando el conocimiento del algoritmo de generación y acoplando módulos entre sí.

---

## 2. Solución Propuesta: SeedService

Módulo independiente con una única responsabilidad: **generar la semilla y exponer consultas deterministas** para el resto del sistema.

### 2.1 Interfaz sugerida

```
SeedService
  ├── generateSeed() → seedId
  ├── getEnemyAt(location, day, hour) → EnemyBlueprint
  ├── getItemStats(itemId) → ItemStats
  ├── getDailyMission(day) → MissionBlueprint
  ├── getEventAt(location) → EventBlueprint
  ├── getMalDelMundo() → MalType
  ├── getRitualPages() → PageBlueprint[]
  └── getRewardPool(enemyId) → Reward[]
```

### 2.2 Requerimientos funcionales sugeridos (para agregar en próxima revisión)

| ID | Requerimiento | Prioridad | CU origen |
|:--:|---------------|:---------:|:---------:|
| RF-66 | El sistema debe exponer un servicio central que, dada una semilla, responda consultas deterministas para cada módulo: ubicación de eventos, estadísticas de objetos, datos de enemigos, misiones diarias, recompensas, tipo de Mal del Mundo y páginas de ritual. | Alta | CU-01 |
| RF-67 | El sistema debe garantizar que, para una misma semilla y los mismos parámetros de consulta (ej. día, ubicación), la respuesta sea siempre idéntica en todas las iteraciones de la partida. | Alta | CU-01 |
| RF-68 | El sistema debe permitir que cada módulo (Inventario, Combate, Exploración, Misiones, Jefe Final) consuma datos de la semilla sin conocer el algoritmo de generación interno. | Media | CU-01 |

---

## 3. Impacto en el Orden de Implementación

Con SeedService como base, el orden propuesto cambia a:

| Paso | Módulo | Dependencias |
|:----:|--------|:-------------|
| **0** | **SeedService** | _Ninguna_ |
| 1 | Inventario y Equipamiento | SeedService (clasificación y stats de objetos) |
| 2 | Gestión de Partida | SeedService + Inventario |
| 3 | Conocimiento (Libro + Estudio) | SeedService + Inventario + Partida |
| 4 | Exploración y Tiempo | SeedService + Partida |
| 5 | Combate | SeedService + Inventario + Partida + Conocimiento |
| 6 | Economía y Servicios | SeedService + Partida + Inventario |
| 7 | Misiones | SeedService + Partida + Combate |
| 8 | Jefe Final | SeedService + Combate + Conocimiento + Partida |
| 9 | Maldiciones | Partida + Inventario |

### 3.1 Ventajas

| Aspecto | Beneficio |
|---------|-----------|
| **Testabilidad** | Cada módulo recibe un mock/fake de SeedService. No se requiere semilla real en tests unitarios. |
| **Determinismo** | Una sola fuente de verdad para la semilla. Un solo punto donde validar idempotencia. |
| **Desacoplamiento** | Cambiar el algoritmo de generación (ej. seed numérica → seed con hash) no afecta ningún otro módulo. |
| **Claridad arquitectónica** | La dependencia es unidireccional: los módulos consumen SeedService, SeedService no conoce a los módulos. |

### 3.2 Posible objeción

> "Es overengineering para un proyecto chico. Podemos pasar el seedId a cada función que lo necesite."

**Contraargumento:** Sin una interfaz central, cada módulo termina reimplementando la lógica de "dado un seedId y unas coordenadas, ¿qué enemigo aparece?" — duplicación que, en un proyecto con 65+ RFs, se vuelve deuda técnica temprana. SeedService es una interfaz (o clase abstracta) liviana; la implementación concreta puede ser tan simple como un switch o un lookup table en la primera iteración.

---

*Fin de la propuesta — Revisar y decidir en próxima reunión de análisis.*


### 3.3 Material de Referencia

- [Setting the Seed In Godot - YouTube](https://www.youtube.com/watch?v=Aax4ZoFhIzY)
