class_name MissionBlueprint
extends Resource

@export var mission_id: String
@export var day: int
@export var objective: String
@export var target_enemy_id: String
@export var location: Vector2
@export var reward: Reward
@export var time_limit_days: int
@export var hints: Array[String] = []
