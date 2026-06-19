extends Node

var seed_service: SeedService
var seed_id: int
var day: int = 1
var hour: int = 8
var threat_level: float = 0.0
var player_stats: Dictionary = {}
var inventory: Array = []
var equipped: Dictionary = {
	"head": null,
	"chest": null,
	"hand_l": null,
	"hand_r": null,
	"ring_l": [null, null, null, null],
	"ring_r": [null, null, null, null]
}
var money: int = 0
var book_entries: Dictionary = {}
var active_curses: Array = []
var active_missions: Array = []
var status_effects: Array = []
var passive_skills: Array = []
var unlocked_spells: Dictionary = {}
var ritual_pages_found: Array = []

func init_run(p_seed_id: int, p_seed_service: SeedService, character_stats: Dictionary, modifiers: Array) -> void:
	seed_id = p_seed_id
	seed_service = p_seed_service
	day = 1
	hour = 8
	threat_level = 0.0
	player_stats = character_stats.duplicate()
	inventory.clear()
	equipped = {
		"head": null, "chest": null,
		"hand_l": null, "hand_r": null,
		"ring_l": [null, null, null, null],
		"ring_r": [null, null, null, null]
	}
	money = 0
	book_entries.clear()
	active_curses.clear()
	active_missions.clear()
	status_effects.clear()
	passive_skills = character_stats.get("base_passives", []).duplicate()
	unlocked_spells.clear()
	ritual_pages_found.clear()
	_apply_modifiers(modifiers)

func _apply_modifiers(modifiers: Array) -> void:
	for mod in modifiers:
		match mod.get("id"):
			"threat_20": threat_level = 20.0
			"lower_stats": _scale_stats(0.8)
			"death_penalty": pass
			"worse_rewards": pass

func _scale_stats(factor: float) -> void:
	for key in ["hp", "mp", "combat_ap", "explore_energy"]:
		if player_stats.has(key):
			player_stats[key] = int(player_stats[key] * factor)

func regular_death() -> void:
	inventory.clear()
	money = 0
	active_missions.clear()
	status_effects.clear()
	passive_skills = player_stats.get("base_passives", []).duplicate()
	threat_level = min(threat_level + 15.0, 100.0)
	day = 1
	hour = 8

func definitive_death() -> void:
	seed_id = 0
	seed_service = null
