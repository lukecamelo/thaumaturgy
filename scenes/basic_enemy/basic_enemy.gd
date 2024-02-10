extends CharacterBody2D

@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move()
