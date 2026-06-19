extends Node

var unlocked_modifiers: Array = []
var total_wins: int = 0
var total_deaths: int = 0

func _ready() -> void:
	_load()

func unlock_modifier(mod_id: String) -> void:
	if not mod_id in unlocked_modifiers:
		unlocked_modifiers.append(mod_id)
		_save()

func _save() -> void:
	var file = FileAccess.open("user://game_state.save", FileAccess.WRITE)
	if file:
		var data = {
			"unlocked_modifiers": unlocked_modifiers,
			"total_wins": total_wins,
			"total_deaths": total_deaths
		}
		file.store_var(data)

func _load() -> void:
	var file = FileAccess.open("user://game_state.save", FileAccess.READ)
	if file:
		var data = file.get_var()
		unlocked_modifiers = data.get("unlocked_modifiers", [])
		total_wins = data.get("total_wins", 0)
		total_deaths = data.get("total_deaths", 0)
