extends Control

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	# TODO: Character select screen
	var seed_id = SeedServiceGD.new(randi()).generate_seed()
	var seed_service = SeedServiceGD.new(seed_id)
	var stats = {
		"hp": 100, "mp": 50,
		"combat_ap": 6, "explore_energy": 100,
		"base_passives": []
	}
	RunState.init_run(seed_id, seed_service, stats, [])
	SignalBus.partida_iniciada.emit(RunState)
	get_tree().change_scene_to_file("res://scenes/main/Game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
