extends Node
class_name HitflashComponent

@export var health_component: HealthComponent
@export var sprite: Sprite2D
@export var hitflash_material: ShaderMaterial

var hitflash_tween: Tween


func _ready() -> void:
	health_component.health_updated.connect(_on_health_changed)
	sprite.material = hitflash_material


func _on_health_changed() -> void:
	if hitflash_tween != null and hitflash_tween.is_valid():
		hitflash_tween.kill()
	
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hitflash_tween = create_tween()
	hitflash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, .2)\
		.set_trans(Tween.TRANS_CUBIC)
