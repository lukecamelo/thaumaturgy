extends Node
class_name WaveManager

@export var store_screen_scene: PackedScene

var current_wave: int = 1
var enemies: Array = []


func _ready() -> void:
	GameEvents.enemy_died.connect(_on_enemy_died)


func _on_enemy_died(_enemy: CharacterBody2D) -> void:
	var enemies_left_alive = get_tree().get_nodes_in_group("enemy")
	
	# TODO: avoid having to do this yucky shit. the last enemy dies, emits the signal,
	# and then is queue_free'd. because the signal is emitted before the enemy is removed from the tree,
	# the enemies left alive array still has that enemy in it.
	# ideally we would check after the enemy is removed from the tree, since this seems error prone.
	if enemies_left_alive.size() - 1 == 0:
		GameEvents.emit_wave_cleared()
		#on_wave_cleared(1)


func on_wave_cleared(_wave_number: int) -> void:
	# probably do some animations and stuff first?
	# maybe a delay so the player can move around for a bit
	# does the store screen animate itself in?
	var store_screen_instance = store_screen_scene.instantiate() as CanvasLayer
	add_child(store_screen_instance)
