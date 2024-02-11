extends Node

signal player_health_changed(current_health: int)
signal upgrade_applied(current_upgrades: Dictionary)


func emit_player_health_changed(current_health: int):
	player_health_changed.emit(current_health)


func emit_upgrade_applied(current_upgrades: Dictionary) -> void:
	upgrade_applied.emit(current_upgrades)
