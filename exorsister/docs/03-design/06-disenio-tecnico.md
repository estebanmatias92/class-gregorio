# Diseño Técnico — Exorsister v3.0

**Proyecto:** Exorsister
**Fase:** Diseño (SDLC)
**Motor:** Godot 4.x (GDScript)
**Versión:** 1.0

---

## 1. Arquitectura General

```
┌─────────────────────────────────────────────────────┐
│                    SignalBus (Autoload)              │
│  Bus de señales desacoplado: combate_iniciado,       │
│  dia_cambiado, muerte_regular, objeto_identificado…  │
└─────────────────────────────────────────────────────┘
                              │
     ┌────────────────────────┼────────────────────────┐
     ▼                        ▼                        ▼
┌──────────┐          ┌──────────────┐         ┌──────────────┐
│ GameState│          │   RunState   │         │  SeedService │
│ Autoload │          │   Autoload   │         │  (Autoload)  │
│ (meta-   │          │ (partida     │         │              │
│  progreso│          │  actual)     │         │ generateSeed │
│  modifi- │          │              │         │ getEnemyAt   │
│  cadores │          │ seed_id      │         │ getItemStats │
│  desbloq)│          │ day/hour     │         │ getDaily…    │
└──────────┘          │ inventory[]  │         │ getEventAt   │
                      │ book         │         │ getMalDel…   │
                      │ curses[]     │         │ getRitual…   │
                      │ threat_lvl   │         │ getReward…   │
                      │ missions[]   │         └──────────────┘
                      │ player_stats               │
                      │ equipped[]        ┌─────────┼──────────┐
                      └──────────────┘    ▼         ▼          ▼
                                    ┌────────┐ ┌────────┐ ┌──────────┐
                                    │ Combat │ │Explorac│ │ Misiones │
                                    │System  │ │System  │ │ System   │
                                    └────────┘ └────────┘ └──────────┘
```

### 1.1 Autoloads (Singletons)

| Autoload | Rol | Persistencia |
|----------|-----|-------------|
| **SeedService** | Servicio central de semilla: genera y responde consultas deterministas | Solo durante la partida |
| **GameState** | Meta-progresión entre partidas: modificadores desbloqueados, stats globales | Guardado en disco |
| **RunState** | Estado vivo de la partida actual: seed, inventario, libro, barra, etc. | Guardado en disco (auto-save) |
| **SignalBus** | Bus de señales desacoplado para comunicación entre módulos | Volátil |

---

## 2. SeedService — Diseño Detallado

### 2.1 Interfaz

```
SeedService (interfaz abstracta):
  generate_seed() → seedId (int)
  get_enemy_at(location, day, hour) → EnemyBlueprint | null
  get_item_stats(itemId) → ItemStats | null
  get_daily_mission(day) → MissionBlueprint | null
  get_event_at(location) → EventBlueprint | null
  get_mal_del_mundo() → MalType
  get_ritual_pages() → PageBlueprint[]
  get_reward_pool(enemyId) → Reward[]
```

### 2.2 Implementación Concreta

`SeedServiceGD` implementa la interfaz usando `seed_id` como base para un generador pseudoaleatorio interno. Cada consulta es función pura de `seed_id + parámetros`:

- Se mezcla el `seed_id` con un discriminador por tipo de consulta y los parámetros específicos para obtener una seed local.
- Esto garantiza determinismo sin estado mutable entre consultas.

### 2.3 Mock para Tests

`SeedServiceMock` implementa la misma interfaz con setters para valores de retorno, permitiendo testear los sistemas sin semilla real.

---

## 3. Estructura del Proyecto Godot

```
res://
├── scenes/         → .tscn (escenas y nodos)
├── scripts/        → .gd (scripts)
├── assets/         → sprites, fonts, audio (según corresponda)
├── resources/      → .tres (datos configurables: items, enemigos, etc.)
└── project.godot   → archivo de configuración del motor
```

Los módulos del sistema se organizarán de la siguiente forma dentro de `scenes/` y `scripts/`:

```
scenes/
├── main/          → MainMenu, Game, GameOver
├── player/        → Player (nodo del jugador)
├── combat/        → CombatScene, EnemyDisplay
├── exploration/   → MapScene, EventLocation
├── inventory/     → InventoryUI
├── locations/     → House, Hospital, Shop, Library, RitualZone
└── ui/            → BookUI, HUD, SpellInput

scripts/
├── core/          → SeedService, RunState, GameState, SignalBus
├── entities/      → Player, Enemy, EnemyPart
├── systems/       → Combat, Exploration, Time, Mission, Inventory, etc.
├── ui/            → HUD, BookUI, InventoryUI, MenuUI, SpellInput
└── resources/     → EnemyBlueprint, ItemStats, MissionBlueprint, etc.
```

---

## 4. Flujo de Datos

### 4.1 Inicio de Partida

```
MainMenu
  → CharacterSelect (elige personaje base)
  → ModifierSelect (elige modificadores desbloqueados)
  → Game.tscn
      → SeedService.generate_seed() → seed_id
      → RunState.init(seed_id, character, modifiers)
      → SeedService.get_mal_del_mundo() → mal_type
      → SignalBus → "partida_iniciada"
```

### 4.2 Combate

```
Exploración → encuentra enemigo
  → CombatScene
      → SeedService.get_enemy_at(location, day, hour) → EnemyBlueprint
      → Setup del enemigo con anatomía dinámica
      → Turnos alternados: Player → Enemy → Player → ...
        - Ataque físico (según arma equipada)
        - "Hablar" (input en tiempo real, medido en AP por tiempo)
        - Usar objeto / cambiar equipamiento (consume AP)
      → Resultado:
        - Victoria → recompensa (SeedService.get_reward_pool)
        - Muerte Regular → RunState.regular_death() → SignalBus → restart
        - Muerte vs Jefe → RunState.definitive_death() → GameOver
```

### 4.3 Muerte Regular

```
HP = 0 (no Jefe)
  → RunState: purga inventario, dinero, misiones, efectos, pasivas
  → RunState: conserva Libro y Maldiciones
  → RunState: incrementa barra de maldad
  → RunState: reinicia al Día 1 en Casa
  → SignalBus → "muerte_regular"
  → Game.tscn restart
```

---

## 5. Señales del SignalBus

| Señal | Emisor | Receptores | Parámetros |
|-------|--------|------------|------------|
| `partida_iniciada` | Game | Todos los sistemas | RunState |
| `dia_cambiado` | TimeSystem | MissionSystem, HUD | day: int |
| `hora_cambiada` | TimeSystem | HUD | hour: int |
| `mal_del_mundo_activado` | TimeSystem | ShopSystem, CombatSystem | mal_type, threshold |
| `combate_iniciado` | ExplorationSystem | CombatScene, HUD | enemy |
| `combate_terminado` | CombatSystem | ExplorationSystem, MissionSystem | result |
| `enemigo_derrotado` | CombatSystem | MissionSystem, InventorySystem | enemy_id, reward |
| `muerte_regular` | RunState | Game, HUD | — |
| `muerte_definitiva` | RunState | Game | — |
| `mision_asignada` | MissionSystem | HUD | mission |
| `mision_completada` | MissionSystem | HUD, GameState | mission_id |
| `objeto_identificado` | StudySystem | BookUI | item_id |
| `pagina_obtenida` | InventorySystem | BookUI | page |
| `jefe_invocado` | RitualSystem | CombatScene | threat_pct |
| `ritual_fallido` | RitualSystem | UI | — |

---

## 6. Recursos (Data Types)

Todos los datos configurables se definen como recursos de Godot (`.gd` + `.tres`):

| Recurso | Campos clave |
|---------|-------------|
| **EnemyBlueprint** | enemy_id, name, type, parts[], abilities[], reward_pool, spawn_conditions |
| **PartBlueprint** | part_id, name, hp, armor, is_vital |
| **AbilityBlueprint** | ability_id, name, damage, target_part, mp_cost |
| **ItemStats** | item_id, name, type, classification, slot, stats, hidden_abilities, buy_price |
| **MissionBlueprint** | mission_id, day, objective, target_enemy, location, reward, time_limit |
| **EventBlueprint** | event_id, type, condition, rewards |
| **PageBlueprint** | page_id, content, hint, location_hint |
| **CurseResource** | curse_id, name, description, benefit, drawback, removal_item |
| **SpellResource** | spell_id, name, damage, mp_cost, base_ap_cost |

---

## 7. Orden de Implementación por Módulo

| Paso | Módulo | Dependencias | Descripción |
|:----:|--------|:-------------|-------------|
| 0 | **SeedService** | — | Generación de semilla + consultas deterministas |
| 1 | **RunState + GameState** | Paso 0 | Estado de partida y meta-progresión |
| 2 | **Inventario y Equipamiento** | Pasos 0-1 | Sistema de items, equipamiento, slots |
| 3 | **Conocimiento (Libro + Estudio)** | Pasos 0-2 | Documentación, identificación de objetos |
| 4 | **Exploración y Tiempo** | Pasos 0-1 | Mapa, ciclo día/noche, energía, descanso |
| 5 | **Combate** | Pasos 0-4 | Turnos, anatomía dinámica, habilidad "Hablar" |
| 6 | **Economía y Servicios** | Pasos 0-2, 4 | Tienda, hospital, biblioteca |
| 7 | **Misiones** | Pasos 0-5 | Asignación diaria, seguimiento, recompensas |
| 8 | **Jefe Final** | Pasos 0-7 | Invocación, escalado por amenaza, buffos |
| 9 | **Maldiciones** | Pasos 0-2 | Adquisición, persistencia, remoción |

---

## 8. Decisiones Arquitectónicas

| Decisión | Opción | Alternativa | Razón |
|----------|--------|-------------|-------|
| Comunicación entre módulos | SignalBus (señales Godot) | Llamadas directas | Desacoplamiento total, fácil testear |
| SeedService | Autoload singleton | Inyección por constructor | Godot no tiene DI nativa; Autoload es el estándar |
| Datos de semilla | PRNG con hash de seed+params | Lookup tables precargadas | Menos memoria, más flexible |
| Persistencia | ResourceSaver/Loader (JSON) | SQLite | Nativo de Godot, tipado |
| Anatomía del enemigo | Array de nodos hijo | Diccionario de stats | Visual: cada parte es renderizable individualmente |

---

*Fin del documento — Diseño Técnico Exorsister v1.0*
