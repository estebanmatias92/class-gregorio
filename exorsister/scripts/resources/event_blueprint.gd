class_name EventBlueprint
extends Resource

enum Type { COMBAT, TESORO, ENCUENTRO, PELIGRO }

@export var event_id: String
@export var event_type: Type
@export var condition: Dictionary = {}
@export var rewards: Array[Reward] = []
@export var description: String = ""
