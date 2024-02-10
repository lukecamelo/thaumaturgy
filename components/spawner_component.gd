extends Node2D

@export var spawn_scene: PackedScene


func spawn(spawn_position: Vector2 = global_position, parent = get_tree().root):
	var spawn_instance = spawn_scene.instantiate() as Node2D
	spawn_instance.global_position = spawn_position
	parent.add_child(spawn_instance)
	
