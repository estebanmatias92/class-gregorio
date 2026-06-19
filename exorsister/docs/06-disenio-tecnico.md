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

### 2.1 Interfaz Abstracta

```
class_name SeedService
extends RefCounted

func generate_seed() -> int
func get_enemy_at(location: Vector2, day: int, hour: int) -> EnemyBlueprint
func get_item_stats(item_id: String) -> ItemStats
func get_daily_mission(day: int) -> MissionBlueprint
func get_event_at(location: Vector2) -> EventBlueprint
func get_mal_del_mundo() -> MalType
func get_ritual_pages() -> Array[PageBlueprint]
func get_reward_pool(enemy_id: String) -> Array[Reward]
```

### 2.2 Implementación Concreta

`SeedServiceGD` implementa la interfaz usando `seed_id` como base para un `RandomNumberGenerator` interno. Cada consulta es función pura de `seed_id + parámetros`:

```
SeedServiceGD
  ├── _rng: RandomNumberGenerator (inicializado con seed_id)
  ├── _hash(params) → int      → mezcla seed_id + parámetros para cada consulta
  └── (cada método usa _rng con un hash distinto para mantener independencia)
```

- `_rng.seed = hash(seed_id + "enemy" + str(location.x) + ...)`
- Esto garantiza determinismo sin estado mutable entre consultas.

### 2.3 Mock para Tests

`SeedServiceMock` implementa la misma interfaz con setters para valores de retorno, permitiendo testear CombatSystem, ExplorationSystem, etc. sin semilla real.

---

## 3. Estructura del Proyecto Godot

```
res://
├── docs/                          # Documentación (solo referencia)
├── assets/
│   ├── sprites/
│   ├── fonts/
│   └── audio/
├── scenes/
│   ├── main/
│   │   ├── MainMenu.tscn           # Menú principal (Nueva Partida, Salir)
│   │   ├── Game.tscn               # Escena raíz de la partida
│   │   └── GameOver.tscn           # Pantalla de muerte definitiva
│   ├── player/
│   │   └── Player.tscn             # Nodo del jugador (stats, equipamiento)
│   ├── combat/
│   │   ├── CombatScene.tscn        # Fase de combate por turnos
│   │   └── EnemyDisplay.tscn       # Visualización de anatomía dinámica
│   ├── exploration/
│   │   ├── MapScene.tscn           # Mapa de la ciudad con localizaciones
│   │   └── EventLocation.tscn      # Punto de evento genérico
│   ├── inventory/
│   │   └── InventoryUI.tscn        # Pantalla de inventario + equipamiento
│   ├── locations/
│   │   ├── House.tscn              # Casa (Hub)
│   │   ├── Hospital.tscn           # Hospital (curación)
│   │   ├── Shop.tscn               # Tienda
│   │   ├── Library.tscn            # Biblioteca
│   │   └── RitualZone.tscn         # Zona de rituales
│   └── ui/
│       ├── BookUI.tscn             # El Libro (conocimiento)
│       ├── HUD.tscn                # HUD principal (barra maldad, HP, reloj)
│       └── SpellInput.tscn         # Mini-input para "Hablar" en combate
├── scripts/
│   ├── core/
│   │   ├── seed_service.gd         # Interfaz abstracta SeedService
│   │   ├── seed_service_gd.gd      # Implementación concreta
│   │   ├── seed_service_mock.gd    # Mock para tests
│   │   ├── game_state.gd           # Autoload — meta-progresión
│   │   ├── run_state.gd            # Autoload — estado de partida
│   │   └── signal_bus.gd           # Autoload — bus de señales
│   ├── entities/
│   │   ├── player.gd               # Nodo jugador (lógica)
│   │   ├── enemy.gd                # Nodo enemigo (anatomía, IA)
│   │   └── enemy_part.gd           # Parte anatómica individual
│   ├── systems/
│   │   ├── combat_system.gd        # Lógica de combate por turnos
│   │   ├── exploration_system.gd   # Lógica de exploración y tiempo
│   │   ├── time_system.gd          # Ciclo día/noche, barra de maldad
│   │   ├── mission_system.gd       # Asignación y seguimiento de misiones
│   │   ├── inventory_system.gd     # Lógica de inventario y equipamiento
│   │   ├── study_system.gd         # Lógica del Estudio (envío/revelación)
│   │   ├── shop_system.gd          # Lógica de tienda
│   │   ├── hospital_system.gd      # Lógica de hospital
│   │   ├── library_system.gd       # Lógica de biblioteca
│   │   ├── ritual_system.gd        # Lógica de invocación del Jefe
│   │   └── curse_system.gd         # Lógica de maldiciones
│   ├── ui/
│   │   ├── hud.gd                  # Controlador del HUD
│   │   ├── book_ui.gd              # Controlador del Libro
│   │   ├── inventory_ui.gd         # Controlador del inventario
│   │   ├── menu_ui.gd              # Controlador del menú principal
│   │   └── spell_input.gd          # Controlador de "Hablar"
│   └── resources/
│       ├── enemy_blueprint.gd      # Recurso: blueprint de enemigo
│       ├── item_stats.gd           # Recurso: estadísticas de objeto
│       ├── mission_blueprint.gd    # Recurso: blueprint de misión
│       ├── event_blueprint.gd      # Recurso: blueprint de evento
│       ├── page_blueprint.gd       # Recurso: página de ritual
│       ├── spell_resource.gd       # Recurso: hechizo
│       └── curse_resource.gd       # Recurso: maldición
├── resources/
│   ├── items/                      # Items precargados (.tres)
│   ├── enemies/                    # Blueprints de enemigos (.tres)
│   └── modifiers/                  # Modificadores de dificultad (.tres)
└── project.godot
```

---

## 4. Diagrama de Flujo de Datos

### 4.1 Flujo de Inicio de Partida

```
MainMenu
  │  Selecciona "Nueva Partida"
  ▼
CharacterSelect
  │  Elige personaje base
  ▼
ModifierSelect
  │  Elige modificadores (si hay desbloqueados)
  ▼
Game.tscn
  ├── SeedService.generate_seed() → seed_id
  ├── RunState.init(seed_id, character, modifiers)
  ├── SeedService.get_mal_del_mundo() → mal_type
  └── SignalBus.emit("partida_iniciada", run_state)
```

### 4.2 Flujo de Combate

```
Player entra en zona con enemigo
  │  ExplorationSystem.check_for_enemy()
  ▼
CombatScene.tscn
  ├── SeedService.get_enemy_at(location, day, hour) → EnemyBlueprint
  ├── Enemy.setup_from_blueprint(blueprint)
  ├── Player.turn_start()
  │   ├── (ataque físico) → EnemyPart.apply_damage()
  │   ├── ("Hablar")     → SpellInput.check_spell()
  │   ├── (usar objeto)  → InventorySystem.use_item()
  │   └── (cambiar equipo) → InventorySystem.equip()
  ├── Player.turn_end()
  ├── Enemy.turn_execute()
  └── Loop hasta: muerte o retirada
       ├── Muerte Regular  → RunState.reset_to_day1()
       └── Muerte vs Jefe  → GameOver.tscn
```

### 4.3 Flujo de Muerte Regular

```
HP = 0 (no Jefe)
  │
  ▼
RunState.purge_inventory()
RunState.purge_money()
RunState.purge_missions()
RunState.purge_status_effects()
RunState.purge_nonbase_passives()
  │  (conserva: Book, Curses)
  ▼
RunState.increase_threat()
RunState.reset_to_day1()
  │
  ▼
SignalBus.emit("muerte_regular")
Game.tscn restart
```

---

## 5. Señales del SignalBus

| Señal | Emisor | Receptores | Parámetros |
|-------|--------|------------|------------|
| `partida_iniciada` | Game | Todos los sistemas | RunState |
| `dia_cambiado` | TimeSystem | MissionSystem, HUD | day: int |
| `hora_cambiada` | TimeSystem | HUD | hour: int |
| `mal_del_mundo_activado` | TimeSystem | ShopSystem, CombatSystem | mal_type, threshold |
| `combate_iniciado` | ExplorationSystem | CombatScene, HUD | enemy: Enemy |
| `combate_terminado` | CombatSystem | ExplorationSystem, MissionSystem | result: String |
| `enemigo_derrotado` | CombatSystem | MissionSystem, InventorySystem | enemy_id, reward |
| `muerte_regular` | RunState | Game, HUD | — |
| `muerte_definitiva` | RunState | Game | — |
| `mision_asignada` | MissionSystem | HUD | mission: Mission |
| `mision_completada` | MissionSystem | HUD, GameState | mission_id |
| `objeto_identificado` | StudySystem | BookUI | item_id |
| `pagina_obtenida` | InventorySystem | BookUI | page: Page |
| `jefe_invocado` | RitualSystem | CombatScene | threat_pct: float |

---

## 6. Recursos (Resources)

Todos los datos configurables se definen como recursos de Godot (`.gd` + `.tres`):

### EnemyBlueprint
```
enemy_id: String
display_name: String
enemy_type: EnemyType (ERRANTE, TERRITORIAL, FANTASMAL, ESPECIAL)
parts: Array[PartBlueprint]
abilities: Array[AbilityBlueprint] (orden fijo)
reward_pool: Array[Reward]
spawn_conditions: Dictionary (día, hora, etc.)
```

### ItemStats
```
item_id: String
display_name: String
item_type: ItemType (ARMA, ARMADURA, ANILLO, CONSUMIBLE)
classification: float (0.0 - 5.0)
weapon_type: WeaponType (BASICA, MAGICA, MALDITA, SAGRADA)
slot: SlotType (MANO, CABEZA, PECHERA, DEDO)
stats: Dictionary (damage, defense, etc.)
hidden_abilities: Array[String] (requiere Estudio para revelar)
description: String
```

### MissionBlueprint
```
day: int
objective: String (ej. "derrotar a X en Y")
target_enemy_id: String
location: Vector2
reward: Reward
time_limit_days: int
hints: Array[String]
```

---

## 7. Orden de Implementación por Módulo

| Paso | Módulo | Dependencias | Archivos a crear |
|:----:|--------|:-------------|:-----------------|
| 0 | **SeedService** | — | `seed_service.gd`, `seed_service_gd.gd`, `seed_service_mock.gd` |
| 1 | **RunState + GameState** | Paso 0 | `run_state.gd`, `game_state.gd`, `signal_bus.gd` |
| 2 | **Inventario y Equipamiento** | Pasos 0-1 | `inventory_system.gd`, `InventoryUI.tscn`, `ItemStats` resource |
| 3 | **Conocimiento (Libro + Estudio)** | Pasos 0-2 | `book_ui.gd`, `study_system.gd`, `BookUI.tscn` |
| 4 | **Exploración y Tiempo** | Pasos 0-1 | `exploration_system.gd`, `time_system.gd`, `MapScene.tscn` |
| 5 | **Combate** | Pasos 0-4 | `combat_system.gd`, `CombatScene.tscn`, `enemy.gd`, `EnemyBlueprint` |
| 6 | **Economía y Servicios** | Pasos 0-2, 4 | `shop_system.gd`, `hospital_system.gd`, `library_system.gd` |
| 7 | **Misiones** | Pasos 0-5 | `mission_system.gd`, `MissionBlueprint` |
| 8 | **Jefe Final** | Pasos 0-7 | `ritual_system.gd`, boss variants |
| 9 | **Maldiciones** | Pasos 0-2 | `curse_system.gd`, `CurseResource` |

---

## 8. Decisiones Arquitectónicas

| Decisión | Opción elegida | Alternativa descartada | Razón |
|----------|---------------|----------------------|-------|
| Comunicación entre módulos | SignalBus (señales Godot) | Llamadas directas | Desacoplamiento total, fácil testear |
| SeedService | Autoload singleton | Inyección por constructor | Godot no tiene DI nativa; Autoload es el patrón estándar |
| Datos de semilla | `RandomNumberGenerator` con hash de seed+params | Lookup tables precargadas | Menos memoria, más flexible |
| Persistencia | `ResourceSaver`/`ResourceLoader` con JSON | SQLite / archivos planos | Nativo de Godot, tipado |
| Anatomía del enemigo | Array de nodos `EnemyPart` | Diccionario de stats | Visual: cada parte es un nodo hijo renderizable |
| Habilidad "Hablar" | Input en tiempo real + timer | Selector de menú | Es un requisito explícito del diseño de juego |

---

*Fin del documento — Diseño Técnico Exorsister v1.0*
