extends Node

signal player_health_changed(current_health: int)
signal upgrade_applied(current_upgrades: Dictionary, chosen_upgrade: Upgrade)
signal enemy_died(enemy: CharacterBody2D)
signal wave_cleared


func emit_player_health_changed(current_health: int):
	player_health_changed.emit(current_health)


func emit_upgrade_applied(current_upgrades: Dictionary, chosen_upgrade: Upgrade) -> void:
	print("emitting upgrade")
	upgrade_applied.emit(current_upgrades, chosen_upgrade)


func emit_enemy_died(enemy: CharacterBody2D) -> void:
	enemy_died.emit(enemy)


func emit_wave_cleared() -> void:
	wave_cleared.emit()
