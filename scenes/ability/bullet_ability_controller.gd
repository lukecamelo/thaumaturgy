extends Node

@export var bullet_ability: PackedScene
@export var base_damage: int = 5

@onready var cooldown_timer: Timer = $CooldownTimer

var projectile_size: float = 1.0


func _ready() -> void:
	GameEvents.upgrade_applied.connect(_on_upgrade_applied)


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
	
	bullet.global_rotation = bullet.direction.angle() + deg_to_rad(90)
	bullet.scale = Vector2(projectile_size, projectile_size)


func _on_upgrade_applied(current_upgrades: Dictionary) -> void:
	if current_upgrades["projectile_size_increase"]:
		var projectile_size_modifier: float = current_upgrades["projectile_size_increase"]["resource"].projectile_size_modifier
		var upgrade_count = current_upgrades["projectile_size_increase"]["quantity"]
		
		projectile_size = projectile_size * upgrade_count * projectile_size_modifier
