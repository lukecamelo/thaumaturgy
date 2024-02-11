extends Node
class_name HealthComponent

signal died
signal health_updated

@export var max_health: int = 5
var current_health: int


func _ready() -> void:
	current_health = max_health


func damage(damage_amount: int) -> void:
	current_health = max(current_health - damage_amount, 0)
	health_updated.emit()
	Callable(check_death).call_deferred()


func check_death() -> void:
	if current_health == 0:
		died.emit()
		owner.queue_free()
