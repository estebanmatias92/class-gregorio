# Exorsister — AGENTS.md

RPG táctico Godot 4.x (GDScript). SDLC: Análisis completo, Diseño en curso.
**NO implementar código ni crear project.godot** — el proyecto no está en fase de implementación aún.

## Documentación (docs/)

Organizada por fase SDLC con prefijos numéricos:
- `01-re/` — Requirements Engineering (brief, glosario)
- `02-analysis/` — Casos de uso, catálogo RF/RNF, propuesta semilla
- `02-analysis/requerimientos/{NN-modulo}/{ID}.md` — fichas individuales con criterios de aceptación
- `03-design/` — Diseño técnico (arquitectura, flujos, orden de implementación)

Template para fichas: `02-analysis/requerimientos/TEMPLATE-ficha-requerimiento.md`

## Skills del proyecto

Cargar con `skill("especificar-ficha")` — genera fichas de requerimiento individuales.
Ubicación: `.opencode/skills/especificar-ficha/SKILL.md`

## Orden de implementación futuro

Definido en `03-design/06-disenio-tecnico.md` §7.
SeedService → Inventario → Partida → Conocimiento → Exploración → Combate → Economía → Misiones → Jefe Final → Maldiciones
