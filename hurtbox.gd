extends Area2D
class_name Hurtbox

signal hit

@export var health_component: HealthComponent

var is_invincible: bool = false


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null or health_component == null:
		return
	
	if !is_invincible:
		health_component.take_damage(hitbox.damage)
		
		hit.emit()
		hitbox.hit_hurtbox.emit(self)
