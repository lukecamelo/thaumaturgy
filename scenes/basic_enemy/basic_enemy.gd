extends CharacterBody2D

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var health_component: HealthComponent = $HealthComponent


func _ready() -> void:
	health_component.died.connect(_on_died)


func _process(_delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move()


func _on_died() -> void:
	GameEvents.emit_enemy_died(self)
