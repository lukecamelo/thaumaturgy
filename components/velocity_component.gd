extends Node
class_name VelocityComponent

@export var entity: CharacterBody2D
@export var max_speed: int = 40
@export var acceleration: float = 5

var velocity: Vector2 = Vector2.ZERO


func accelerate_to_player() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var direction: Vector2 = (player.global_position - entity.global_position).normalized()
	accelerate_in_direction(direction)


func accelerate_in_direction(direction: Vector2) -> void:
	var target_velocity = direction * max_speed
	velocity = velocity.lerp(target_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func decelerate() -> void:
	accelerate_in_direction(Vector2.ZERO)


func move() -> void:
	entity.velocity = velocity
	entity.move_and_slide()
	velocity = entity.velocity
