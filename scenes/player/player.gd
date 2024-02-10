extends CharacterBody2D
class_name Player

const MAX_SPEED := 80
const ACCELERATION := 25
const ROTATION_SPEED := 10

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var invincibility_timer: Timer = $InvincibilityTimer


func _ready() -> void:
	invincibility_timer.timeout.connect(_on_invincibility_timer_timeout)
	hurtbox_component.hit.connect(_on_hit)


func _process(delta: float) -> void:
	var movement_vector := get_movement_vector()
	if movement_vector.length() > 0:
		var direction := movement_vector.normalized()
		
		# Update velocity and move
		velocity = direction * MAX_SPEED
		move_and_slide()
		tilt_character(movement_vector, delta)


func get_movement_vector() -> Vector2:
	var x_movement := Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_movement := Input.get_action_strength("down") - Input.get_action_strength("up")
	
	return Vector2(x_movement, y_movement)


func tilt_character(movement_vector: Vector2, delta: float) -> void:
	var target_rotation: float
	var current_rotation = rotation
	
	if movement_vector.x != 0:
		target_rotation = deg_to_rad(movement_vector.x * 15)
	else:
		target_rotation = 0
	
	global_rotation = lerp_angle(current_rotation, target_rotation, delta * ROTATION_SPEED)


func _on_hit() -> void:
	GameEvents.emit_player_health_changed(health_component.current_health)
	hurtbox_component.is_invincible = true
	invincibility_timer.start()


func _on_invincibility_timer_timeout() -> void:
	hurtbox_component.is_invincible = false
