---
name: especificar-ficha
description: "Genera o completa la ficha individual de un requerimiento (RF o RNF) del proyecto Exorsister, con ID, descripción, criterios de aceptación y backlog de tareas. Usar cuando se necesite desglosar un ítem del catálogo de requerimientos en su especificación detallada."
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

1. Leer `docs/02-analysis/05-requerimientos.md` para identificar el RF/RNF a especificar y sus metadatos (módulo, prioridad, CU origen).
2. Leer `docs/02-analysis/04-casos-de-uso.md` para entender el contexto funcional del CU origen.
3. Leer `docs/02-analysis/requerimientos/TEMPLATE-ficha-requerimiento.md` para usar la plantilla.
4. Crear `docs/02-analysis/requerimientos/{NN-modulo}/{ID}.md` con el contenido completo.
5. Verificar que el archivo se haya creado correctamente y esté en el directorio correcto.

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
