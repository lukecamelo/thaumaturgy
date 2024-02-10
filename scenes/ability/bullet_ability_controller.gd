extends Node

@export var bullet_ability: PackedScene
@export var base_damage: int = 5

@onready var cooldown_timer: Timer = $CooldownTimer


func _ready() -> void:
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire") and cooldown_timer.is_stopped():
		fire_bullet()
		cooldown_timer.start()


func fire_bullet() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var bullet_direction: Vector2 = get_viewport().get_mouse_position() - player.global_position
	var bullet = bullet_ability.instantiate() as Node2D

	get_tree().root.add_child(bullet)
	
	bullet.global_position = player.global_position
	bullet.direction = bullet_direction.normalized()
	var direction_degrees = rad_to_deg(bullet.direction.angle())
	print(direction_degrees)
	#bullet.sprite_2d.rotation = bullet.direction.angle() + deg_to_rad(90)
	bullet.global_rotation = bullet.direction.angle() + deg_to_rad(90)


func _on_cooldown_timer_timeout() -> void:
	pass
