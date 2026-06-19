class_name SeedService
extends RefCounted

func generate_seed() -> int:
	push_error("SeedService.generate_seed() not implemented")
	return 0

func get_enemy_at(location: Vector2, day: int, hour: int):
	push_error("SeedService.get_enemy_at() not implemented")
	return null

func get_item_stats(item_id: String):
	push_error("SeedService.getItemStats() not implemented")
	return null

func get_daily_mission(day: int):
	push_error("SeedService.getDailyMission() not implemented")
	return null

func get_event_at(location: Vector2):
	push_error("SeedService.getEventAt() not implemented")
	return null

func get_mal_del_mundo():
	push_error("SeedService.getMalDelMundo() not implemented")
	return null

func get_ritual_pages() -> Array:
	push_error("SeedService.getRitualPages() not implemented")
	return []

func get_reward_pool(enemy_id: String) -> Array:
	push_error("SeedService.getRewardPool() not implemented")
	return []
