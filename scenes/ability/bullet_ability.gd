extends Node2D
class_name BulletAbility

signal bullet_hit(position: Vector2, direction: Vector2, hit_hurtbox: Area2D)

@export var hit_particles_scene: PackedScene
@onready var hitbox: Hitbox = $Hitbox
@onready var sprite_2d: Sprite2D = $Sprite2D

var speed := 250
var damage: int = 1
var direction := Vector2.ZERO


func _ready() -> void:
	hitbox.damage = damage
	hitbox.hit_hurtbox.connect(_on_hitbox_hit_hurtbox)


func _process(delta: float) -> void:
	position += direction * speed * delta


func create_particles() -> void:
	var hit_particles = hit_particles_scene.instantiate() as HitParticleComponent
	get_tree().root.add_child(hit_particles)
	
	hit_particles.global_position = global_position
	hit_particles.emit_particles()


func hit_something(hit_hurtbox: Area2D) -> void:
	create_particles()
	bullet_hit.emit(global_position, direction, hit_hurtbox)
	queue_free()


func _on_hitbox_hit_hurtbox(hurtbox: Hurtbox) -> void:
	hit_something(hurtbox)


func _on_boundary_detector_area_entered(_area: Area2D) -> void:
	create_particles()
	queue_free()
