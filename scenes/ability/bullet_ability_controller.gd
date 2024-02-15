extends Node
class_name BulletAbilityController

@export var bullet_ability: PackedScene
@export var base_damage: int = 3
@export var projectile_size: float = 1.0

@onready var cooldown_timer: Timer = $CooldownTimer

var has_bullet_burst_upgrade: bool = false


func _ready() -> void:
	GameEvents.upgrade_applied.connect(_on_upgrade_applied)
	GameEvents.enemy_died.connect(_on_enemy_died)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire") and cooldown_timer.is_stopped():
		fire_bullet()
		cooldown_timer.start()


func fire_bullet() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var bullet_direction: Vector2 = get_viewport().get_mouse_position() - player.global_position
	spawn_bullet(player.global_position, bullet_direction)


func spawn_bullet(position: Vector2, direction: Vector2) -> void:
	var bullet = bullet_ability.instantiate() as Node2D
	
	bullet.scale = Vector2(projectile_size, projectile_size)
	bullet.global_position = position
	bullet.direction = direction.normalized()
	bullet.global_rotation = bullet.direction.angle() + deg_to_rad(90)
	
	bullet.damage = base_damage
	
	bullet.bullet_hit.connect(_on_bullet_hit)
	
	get_tree().root.call_deferred("add_child", bullet)


func spawn_bullet_burst_bullet(position: Vector2, direction: Vector2) -> void:
	var bullet = bullet_ability.instantiate() as BulletAbility
	
	bullet.scale = Vector2(projectile_size / 2, projectile_size / 2)
	bullet.speed = roundi(bullet.speed / 2)
	bullet.global_position = position
	bullet.direction = direction.normalized()
	bullet.global_rotation = bullet.direction.angle() + deg_to_rad(90)
	
	bullet.damage = roundi(base_damage / 2)
	
	bullet.bullet_hit.connect(_on_bullet_hit)
	
	get_tree().root.call_deferred("add_child", bullet)


# on hit effects go here possibly
func _on_bullet_hit(position: Vector2, direction: Vector2, hit_hurtbox: Area2D) -> void:
	pass


func _on_upgrade_applied(current_upgrades: Dictionary, chosen_upgrade: Upgrade) -> void:
	if chosen_upgrade.id == "projectile_size_increase":
		var projectile_size_modifier: float = current_upgrades["projectile_size_increase"]["resource"].projectile_size_modifier
		var upgrade_count: int = current_upgrades["projectile_size_increase"]["quantity"]
		
		projectile_size = projectile_size * upgrade_count * projectile_size_modifier
	if chosen_upgrade.id == "bullet_burst":
		has_bullet_burst_upgrade = true


func _on_enemy_died(dying_enemy: CharacterBody2D) -> void:
	if has_bullet_burst_upgrade:
		var spawn_position: Vector2 = dying_enemy.global_position
		var left_direction = Vector2.LEFT
		var down_left_direction = Vector2(-1, 1)
		var right_direction = Vector2.RIGHT
		var down_right_direction = Vector2(1, 1)
		
		spawn_bullet_burst_bullet(spawn_position, left_direction)
		spawn_bullet_burst_bullet(spawn_position, down_left_direction)
		spawn_bullet_burst_bullet(spawn_position, right_direction)
		spawn_bullet_burst_bullet(spawn_position, down_right_direction)
