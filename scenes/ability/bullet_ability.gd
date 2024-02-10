extends Node2D

@export var hit_particles_scene: PackedScene
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var sprite_2d: Sprite2D = $Sprite2D

var speed := 250
var direction := Vector2.ZERO


func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	var hit_particles = hit_particles_scene.instantiate() as HitParticleComponent
	get_tree().root.add_child(hit_particles)
	
	hit_particles.global_position = global_position
	hit_particles.emit_particles()
	
	if area is HurtboxComponent:
		area.take_damage(1)
		
	queue_free()
	
