---
name: especificar-ficha
description: "Genera o completa la ficha individual de un requerimiento (RF o RNF) del proyecto Exorsister, con ID, descripción, criterios de aceptación y backlog de tareas. Incluye gap analysis: identifica qué detalles no están especificados en los docs fuente y los presenta al usuario como preguntas antes de redactar la ficha final."
---

# Especificar Ficha de Requerimiento — Exorsister

Proyecto: Exorsister
SDLC: Análisis — Especificación de Requisitos

## Cuándo usar este skill

- Cuando un RF o RNF del catálogo (`docs/02-analysis/05-requerimientos.md`) aún no tiene su ficha individual en `docs/02-analysis/requerimientos/`
- Cuando se necesita agregar o refinar criterios de aceptación de un requerimiento existente
- Cuando se necesita descomponer un requerimiento en tareas de backlog para implementación

## Formato de output

Cada ficha se guarda como un archivo `{ID}.md` dentro de la subcarpeta del módulo correspondiente en `docs/02-analysis/requerimientos/{NN-modulo}/`.

Usar la plantilla en `docs/02-analysis/requerimientos/TEMPLATE-ficha-requerimiento.md`.

## Estructura de directorio destino

```
docs/02-analysis/requerimientos/
├── TEMPLATE-ficha-requerimiento.md
├── 00-seed-service/       → RF-66 .. RF-68
├── 01-gestion-partida/    → RF-01 .. RF-12
├── 02-exploracion-tiempo/ → RF-13 .. RF-20
├── 03-combate/            → RF-21 .. RF-31
├── 04-inventario-equipamiento/ → RF-32 .. RF-39
├── 05-conocimiento/       → RF-40 .. RF-45
├── 06-economia-servicios/ → RF-46 .. RF-50
├── 07-misiones/           → RF-51 .. RF-55
├── 08-jefe-final/         → RF-56 .. RF-62
├── 09-maldiciones/        → RF-63 .. RF-65
└── 10-no-funcionales/     → RNF-01 .. RNF-15
```

## Procedimiento

### Fase 1: Recolección de contexto

1. Leer `docs/02-analysis/05-requerimientos.md` para identificar el RF/RNF a especificar y sus metadatos (módulo, prioridad, CU origen, dependencias).
2. Leer el CU origen en `docs/02-analysis/04-casos-de-uso.md` para entender el contexto funcional completo.
3. Leer las secciones relevantes del brief (`docs/01-re/02-brief-diseño.md`) que mencionen el módulo o CU.
4. Leer las entradas del glosario (`docs/01-re/03-glossary.md`) relacionadas con los términos del RF.
5. Leer `docs/01-re/01-idea.pdf` si aplica, para capturar la intención original.

### Fase 2: Gap analysis

Por cada aspecto del RF, determinar si los docs fuente especifican suficiente detalle. Clasificar cada aspecto en:

| Marcador | Significado | Qué hacer |
|----------|-------------|-----------|
| ✅ **ESPECIFICADO** | El detalle está en los docs | Usarlo directamente en la ficha |
| 🟡 **INFERIDO** | Se puede deducir de los docs pero no está explícito | Redactar con lenguaje cauto ("Se asume que...") |
| 🔴 **GAP** | No está en ningún doc, no se puede inferir | Formular pregunta al usuario |

Aspectos a evaluar para cada RF:
- **Inputs:** ¿Qué datos/acciones disparan el comportamiento? ¿Hay valores límite?
- **Outputs:** ¿Qué produce el sistema? ¿Formatos, tipos, rangos?
- **Condiciones de borde:** ¿Qué pasa en casos extremos (valores nulos, vacío, límite)?
- **Flujo alternativo:** ¿Hay caminos alternativos al principal? ¿Qué los dispara?
- **Reglas de negocio:** Si el RF tiene lógica condicional, ¿están todas las condiciones documentadas?
- **Métricas/umbrales:** ¿Hay números, tiempos, cantidades que deban definirse?
- **Módulos afectados:** ¿Interactúa con otros módulos? ¿Cómo?

Generar una tabla de gaps como artefacto intermedio:

```
## Gap analysis — {ID}

| Aspecto | Estado | Fuente | Pregunta |
|---------|--------|--------|----------|
| Inputs | ✅ Especificado | Brief §X | — |
| Umbral numérico | 🔴 GAP | — | ¿Cuántos objetos puede...? |
| Condición de borde | 🟡 Inferido | CU-YY | Se asume que si X es 0... |
```

### Fase 3: Presentación de gaps al usuario

Si hay gaps 🔴, **no escribir la ficha todavía**. En su lugar:

1. Presentar la tabla de gaps completa al usuario.
2. Para cada gap 🔴, formular una pregunta clara y específica.
3. Esperar respuesta del usuario.
4. Incorporar las respuestas a la ficha.

Si hay inferidos 🟡, mencionarlos pero pueden resolverse sin pregunta explícita.

Si no hay gaps (solo ✅), pasar directamente a la Fase 4.

### Fase 4: Redacción de la ficha

1. Leer `docs/02-analysis/requerimientos/TEMPLATE-ficha-requerimiento.md` para la plantilla.
2. Redactar descripción (1-2 oraciones máximas, clara, sin ambigüedades).
3. Redactar criterios de aceptación:
   - Usar lenguaje Given/When/Then.
   - Cada criterio debe ser verificable por test o inspección.
   - Cubrir: flujo principal, alternativos, condiciones de borde.
4. Redactar backlog de tareas:
   - Descomponer en unidades de implementación atómicas.
   - Asignar dependencias correctamente.
   - Respetar el orden de implementación definido en `docs/03-design/06-disenio-tecnico.md`.
5. Crear `docs/02-analysis/requerimientos/{NN-modulo}/{ID}.md`.

### Fase 5: Verificación

1. Verificar que el archivo se haya creado en el directorio correcto.
2. Confirmar que todos los gaps 🔴 fueron resueltos (respondidos por el usuario o explicitly marcados como decisión futura).
3. Si quedan inferidos 🟡 sin resolver, listarlos como notas al pie.

## Formato del contenido

```
# {ID}: {Título del Requerimiento}

| Campo | Valor |
|-------|-------|
| **ID** | {RF-NNN o RNF-NNN} |
| **Módulo** | {Nombre del módulo} |
| **Prioridad** | {Alta / Media / Baja} |
| **Origen** | {CU-NN} |
| **Dependencias** | {IDs o "Ninguna"} |
| **Tipo** | {Funcional / No Funcional} |

## Descripción

{Texto claro de una o dos frases}

## Criterios de Aceptación

- [ ] {Criterio 1}
- [ ] {Criterio 2}
- [ ] {Criterio 3}

## Backlog Asociado

### {ID}-T{n}: {Nombre de tarea}

- **Prioridad:** {Alta / Media / Baja}
- **Dependencias:** {IDs}
- **Descripción:** {Qué implementar}
- **Criterios de aceptación:**
  - {Verificación}
```

## Notas

- Los criterios de aceptación deben ser verificables (preferir Given/When/Then).
- Las tareas de backlog representan unidades de implementación atómicas.
- Asignar dependencias correctamente entre tareas para respetar el orden de implementación definido en `docs/03-design/06-disenio-tecnico.md`.
- No modificar `05-requerimientos.md` (el catálogo); las fichas individuales son el desglose, no el reemplazo.
- **No saltar la Fase 2 (gap analysis).** Es el paso que evita escribir especificaciones incompletas o inventar detalles que debería decidir el stakeholder.
- Si el usuario responde "lo dejamos para después" a un gap, marcar la ficha con una nota `> **Pendiente:** {aspecto} definido en {decisión futura}`.
