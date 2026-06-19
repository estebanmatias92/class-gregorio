# Flujo SDLC: Requisitos → Análisis → Diseño

> Teoría de ingeniería de software — agnóstico de stack.
> Define cuándo y cómo se producen interfaces, contratos y diagramas
> (class, secuencia, componentes) en el ciclo de vida del software.

---

## 1. Ingeniería de Requisitos (RE)

**Propósito:** Definir QUÉ debe hacer el sistema, sin decir CÓMO.

### Actividades

| Actividad | Artefacto | Pregunta que responde |
|-----------|-----------|----------------------|
| Elicitación | Brief, entrevistas, actas | ¿Qué problema resuelve? |
| Lenguaje ubicuo | Glosario | ¿Cómo nos comunicamos? |
| Especificación funcional | Casos de Uso | ¿Qué interacciones tiene el usuario? |
| Catálogo de requisitos | RF / RNF (tabla priorizada) | ¿Qué debe cumplir el sistema? |
| Validación | Fichas con criterios de aceptación | ¿Cuándo está "terminado"? |
| Línea base | SRS / GDD firmado | Contrato: alcance cerrado |

### Output de RE

- **Brief:** visión del producto, stakeholders, restricciones de alto nivel.
- **Glosario:** vocabulario compartido, definiciones sin ambigüedad.
- **Casos de Uso:** flujos principal y alternativos, pre/postcondiciones.
- **Catálogo RF/RNF:** lista priorizada, trazada a CUs.
- **Fichas individuales:** por cada RF/RNF, criterios de aceptación verificables,
  backlog de tareas.
- **Documento consolidado (SRS/GDD):** línea base firmada que cierra RE.

### NO se produce en RE

- Interfaces de software.
- Diagramas de clases, componentes o secuencia.
- Decisiones de stack tecnológico.
- Código fuente.

---

## 2. Análisis

**Propósito:** Estructurar el dominio del problema y definir los contratos
entre los componentes lógicos del sistema.

### Actividades

| Actividad | Artefacto | Pregunta que responde |
|-----------|-----------|----------------------|
| Modelado del dominio | Diagrama conceptual de entidades | ¿Cuáles son las entidades y sus relaciones? |
| Contratos entre módulos | Interfaces conceptuales | ¿Qué promete cada módulo a los demás? |
| Reglas de negocio | Especificación de comportamiento | ¿Qué condiciones y restricciones rigen las entidades? |
| Validación | Tabla de trazabilidad RF ↔ Módulo | ¿Cada RF está asignado a un módulo? |

### Modelo del dominio

Es una representación **puramente conceptual** de las entidades del sistema
y sus relaciones. Sin tipos de lenguaje, sin herencia de framework.

```
Ejemplo (textual o diagrama):

  Item
  ├── item_id: string
  ├── classification: real (0.0 - 5.0)
  ├── slot: enum { MANO, CABEZA, PECHERA, DEDO }
  └── pertenece a: Inventario

  Inventario
  ├── items: lista de Item
  ├── equipados: mapa slot → Item
  └── pertenece a: Jugador
```

### Contratos entre módulos (interfaces conceptuales)

Cada módulo declara **qué operaciones expone** a los demás módulos,
usando **tipos del dominio** (entidades del modelo). Sin tipos del lenguaje ni
sintaxis de programación.

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

### ¿Qué NO se define en Analysis?

- El stack tecnológico.
- El mapeo de las entidades a construcciones del lenguaje (clases, structs,
  resources, tablas, etc.).
- Diagramas de clases UML (requieren el mapeo anterior).
- Implementación concreta de los métodos.

### Output de Analysis

- **Modelo del dominio:** entidades, atributos, relaciones, reglas.
- **Contratos entre módulos:** interfaces conceptuales con tipos del dominio.
- **Backlog priorizado:** módulos ordenados por dependencias.
- **Casos de uso complementados:** con reglas de negocio explícitas.

---

## 3. Diseño

**Propósito:** Definir CÓMO se construye el sistema, con qué tecnología
y con qué estructura concreta de componentes.

### 3.1 Elección del stack tecnológico

**¿Cuándo se define?** Al inicio del diseño.

Los RNFs **restringen** las opciones (ej: "debe ejecutarse en PC Windows/Linux"
descarta tecnologías web-only, "debe ser multiplataforma" orienta a motores
como Godot o Unity), pero la **decisión concreta** es de diseño.

| Input para la decisión | Ejemplo |
|------------------------|---------|
| RNFs de plataforma | "PC Windows/Linux/Mac" |
| RNFs de rendimiento | "framerate mínimo 60fps" |
| Restricciones del equipo | "Conocemos GDScript, no C#" |
| Presupuesto / licencias | "Open source, sin royalties" |
| Ecosistema requerido | "Integración con Steam, logros, cloud save" |

La decisión de stack impacta directamente en el **mapeo del modelo de análisis**
a componentes concretos:

```
Entidad del dominio    →  Godot Resource   (o clase Java, o tabla SQL)
Servicio               →  Godot Autoload   (o singleton, o microservicio)
Caso de uso            →  Godot Scene      (o página web, o controller)
```

### Actividades

| Actividad | Artefacto | Pregunta que responde |
|-----------|-----------|----------------------|
| Elección de stack | Decisión registrada (ADR) | ¿Con qué tecnología? |
| Mapeo dominio → componentes | Diagrama de componentes | ¿Cómo se traduce el modelo al stack? |
| Interfaces tipadas | Firmas con tipos del lenguaje | ¿Qué parámetros y retornos exactos? |
| Diseño estático | Diagrama de clases UML | ¿Cuáles son las clases, atributos, métodos y relaciones? |
| Diseño dinámico | Diagramas de secuencia | ¿Cómo interactúan los objetos en cada CU? |
| Plan de implementación | Orden de construcción | ¿Qué se implementa primero? |

### Diagrama de clases UML

**Producto del diseño detallado.** Requiere como input:

1. **Entidades del dominio** (del análisis).
2. **Contratos entre módulos** (del análisis).
3. **Mapeo al stack** (del diseño): cada entidad del dominio se convierte en
   una clase concreta, con herencia del framework, anotaciones, etc.

```
Ejemplo (Godot 4.x):

┌───────────────────────────────┐
│        EnemyBlueprint         │  (extends Resource)
├───────────────────────────────┤
│ - enemy_id: String            │
│ - display_name: String        │
│ - enemy_type: EnemyType       │
│ - parts: Array[PartBlueprint] │
│ - abilities: Array[...]       │
│ + get_vital_part(): Part      │
│ + get_reward_pool(): Reward[] │
└───────────────┬───────────────┘
                │ compone
                ▼
┌───────────────────────────────┐
│        PartBlueprint          │  (extends Resource)
├───────────────────────────────┤
│ - part_id: String             │
│ - hp: int                     │
│ - is_vital: bool              │
└───────────────────────────────┘
```

### Diagramas de secuencia

Muestran la interacción temporal entre objetos para un caso de uso específico.
Se producen después del diagrama de clases, cuando las interfaces ya están
resueltas.

```
Ejemplo conceptual:

Jugador    CombatScene    Enemy
   │            │          │
   │── atacar →│          │
   │           │── dañar →│
   │           │          │── verificar_vida()
   │           │          │── return (vivo/muerto)
   │           │←─ resul--│
   │←─ feedback│          │
```

### Output de Diseño

- **Stack definido y documentado.**
- **Diagrama de componentes:** módulos, dependencias, boundaries.
- **Diagrama de clases UML** con herencia, composición, navegabilidad.
- **Diagramas de secuencia** por CU crítico.
- **Interfaces tipadas** con tipos del lenguaje/motor.
- **Plan de implementación** ordenado por dependencias.

---

## 4. Resumen: ¿qué va en cada etapa?

| Artefacto | RE | Analysis | Design |
|-----------|:--:|:--------:|:------:|
| Brief / Visión | ✅ | | |
| Glosario | ✅ | | |
| Casos de Uso | ✅ | | |
| Catálogo RF/RNF | ✅ | | |
| Fichas con ACs | ✅ | | |
| SRS / GDD firmado | ✅ | | |
| Modelo del dominio | | ✅ | |
| Contratos conceptuales | | ✅ | |
| Interfaces (tipos dominio) | | ✅ | |
| Reglas de negocio | | ✅ | |
| Stack tecnológico | | | ✅ |
| Mapeo dominio → componentes | | | ✅ |
| Interfaces tipadas (lenguaje) | | | ✅ |
| Diagrama de clases UML | | | ✅ |
| Diagramas de secuencia | | | ✅ |
| Plan de implementación | | | ✅ |

## 5. Preguntas frecuentes

| Pregunta | Respuesta |
|----------|-----------|
| **¿Cuándo se define el stack?** | Al inicio del Diseño. Los RNFs lo restringen, pero la decisión concreta es de diseño. |
| **¿Un class diagram es de análisis o diseño?** | De diseño. Requiere: entidades del dominio + contratos entre módulos + mapeo a tecnología concreta. Sin el mapeo, es un diagrama conceptual, no un class diagram UML. |
| **¿Interfaces en análisis o diseño?** | En análisis: conceptuales (tipos del dominio). En diseño: tipadas (tipos del lenguaje/motor). Ambas etapas producen interfaces, pero con distinta granularidad. |
| **¿Puedo saltar de RE directo a implementación?** | Sí, si el proyecto es pequeño o el equipo conoce el dominio. Pero los contratos (Analysis) y el diseño estructural (Design) reducen drásticamente la deuda técnica y el retrabajo. |
| **¿Los diagramas son obligatorios?** | No. Son herramientas de comunicación y razonamiento. Un equipo pequeño puede reemplazarlos con código bien estructurado + documentación mínima. El costo es que las decisiones arquitectónicas quedan implícitas. |

---

*Documento teórico — Ingeniería de Software. Agnóstico de stack y tecnología.*
