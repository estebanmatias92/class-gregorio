# Exorsister — AGENTS.md

RPG táctico Godot 4.x (GDScript). SDLC: RE en curso (completar fichas), Análisis no iniciado, Diseño en borrador.
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

## Progreso actual (última actualización: 2026-06-19)

| Módulo | RFs | Fichas | Contrato | Prioridad sig. |
|--------|-----|--------|----------|:--------------:|
| SeedService | 66-68 | ✅ 3/3 | ✅ | — |
| Gestión de Partida | 01-12 | ⬜ 0/12 | ⬜ | 2 |
| Exploración y Tiempo | 13-20 | ⬜ 0/8 | ⬜ | 4 |
| Combate | 21-31 | ⬜ 0/11 | ⬜ | 5 |
| **→ Inventario y Equipamiento** | **32-39** | **⬜ 0/8** | **⬜** | **1 ← SIGUIENTE** |
| Conocimiento | 40-45 | ⬜ 0/6 | ⬜ | 3 |
| Economía y Servicios | 46-50 | ⬜ 0/5 | ⬜ | 6 |
| Misiones | 51-55 | ⬜ 0/5 | ⬜ | 7 |
| Jefe Final | 56-62 | ⬜ 0/7 | ⬜ | 8 |
| Maldiciones | 63-65 | ⬜ 0/3 | ⬜ | 9 |
| No Funcionales | RNF 01-15 | ⬜ 0/15 | ⬜ | 10 |

**Próximo paso:**
`skill("especificar-ficha")` y procesar **Inventario y Equipamiento (RF-32 a RF-39)**.

Leyenda: ✅ completo — ⬜ pendiente — ⏳ en progreso
