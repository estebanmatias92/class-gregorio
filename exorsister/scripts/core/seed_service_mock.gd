class_name SeedServiceMock
extends SeedService

var _enemy_result = null
var _item_result = null
var _mission_result = null
var _event_result = null
var _mal_result = null
var _pages_result = []
var _reward_result = []

func generate_seed() -> int:
	return 12345

func set_enemy_result(value): _enemy_result = value
func set_item_result(value): _item_result = value
func set_mission_result(value): _mission_result = value
func set_event_result(value): _event_result = value
func set_mal_result(value): _mal_result = value
func set_pages_result(value): _pages_result = value
func set_reward_result(value): _reward_result = value

func get_enemy_at(location, day, hour): return _enemy_result
func get_item_stats(item_id): return _item_result
func get_daily_mission(day): return _mission_result
func get_event_at(location): return _event_result
func get_mal_del_mundo(): return _mal_result
func get_ritual_pages(): return _pages_result
func get_reward_pool(enemy_id): return _reward_result
