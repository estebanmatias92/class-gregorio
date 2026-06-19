class_name SeedServiceGD
extends SeedService

var _seed_id: int
var _rng: RandomNumberGenerator

func _init(seed_id: int):
	_seed_id = seed_id
	_rng = RandomNumberGenerator.new()

func generate_seed() -> int:
	return _seed_id

func _hash(base: String) -> int:
	return hash(str(_seed_id) + base)

func get_enemy_at(location: Vector2, day: int, hour: int):
	_rng.seed = _hash("enemy_%s_%d_%d" % [location, day, hour])
	return null # TODO: implement lookup

func get_item_stats(item_id: String):
	_rng.seed = _hash("item_%s" % item_id)
	return null # TODO

func get_daily_mission(day: int):
	_rng.seed = _hash("mission_%d" % day)
	return null # TODO

func get_event_at(location: Vector2):
	_rng.seed = _hash("event_%s" % location)
	return null # TODO

func get_mal_del_mundo():
	_rng.seed = _hash("mal")
	return null # TODO

func get_ritual_pages() -> Array:
	_rng.seed = _hash("ritual")
	return [] # TODO

func get_reward_pool(enemy_id: String) -> Array:
	_rng.seed = _hash("reward_%s" % enemy_id)
	return [] # TODO
