extends Node2D
class_name HitParticleComponent

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func emit_particles() -> void:
	gpu_particles_2d.emitting = true
	await gpu_particles_2d.finished
	queue_free()
