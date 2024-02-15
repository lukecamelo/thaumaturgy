extends Node
class_name EnemyManager

@onready var basic_enemy_scene: PackedScene = preload("res://scenes/basic_enemy/basic_enemy.tscn")


func _ready() -> void:
	pass


func get_spawn_locations() -> Array[Node]:
	return get_tree().get_nodes_in_group("enemy_spawn_location")

 
func _on_timer_timeout() -> void:
	var spawn_locations := get_spawn_locations()
	for spawn_location in spawn_locations:
		pass
		#spawn_enemy(spawn_location)


func spawn_enemy(spawn_location) -> void:
	var enemy = basic_enemy_scene.instantiate() as CharacterBody2D
	
	spawn_location.flash()
	await spawn_location.animation_player.animation_finished
	
	get_tree().root.add_child(enemy)
	enemy.global_position = spawn_location.global_position
