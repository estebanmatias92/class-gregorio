class_name EnemyBlueprint
extends Resource

enum Type { ERRANTE, TERRITORIAL, FANTASMAL, ESPECIAL, MAL_DEL_MUNDO }

@export var enemy_id: String
@export var display_name: String
@export var enemy_type: Type
@export var parts: Array[PartBlueprint]
@export var abilities: Array[AbilityBlueprint]
@export var reward_pool: Array[Reward]
@export var spawn_conditions: Dictionary
