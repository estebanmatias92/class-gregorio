extends Node

signal partida_iniciada(run_state)
signal dia_cambiado(day: int)
signal hora_cambiada(hour: int)
signal mal_del_mundo_activado(mal_type, threshold: float)
signal combate_iniciado(enemy)
signal combate_terminado(result: String)
signal enemigo_derrotado(enemy_id: String, reward)
signal muerte_regular
signal muerte_definitiva
signal mision_asignada(mission)
signal mision_completada(mission_id: String)
signal objeto_identificado(item_id: String)
signal pagina_obtenida(page)
signal jefe_invocado(threat_pct: float)
signal ritual_fallido
