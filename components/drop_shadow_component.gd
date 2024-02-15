extends Node2D

@export var sprite_texture: Resource
@export var entity: Node2D

var shadow_sprite: Sprite2D


func _ready() -> void:
	if sprite_texture == null or entity == null:
		return
	
	shadow_sprite = Sprite2D.new()
	shadow_sprite.texture = sprite_texture
	shadow_sprite.self_modulate = Color("#272939", 0.5)
	
	add_child(shadow_sprite)
	
	shadow_sprite.global_position = entity.global_position
	shadow_sprite.position += Vector2(1, 1)

func _process(_delta: float) -> void:
	if entity.is_in_group("bullet"):
		shadow_sprite.global_rotation = entity.direction.angle() + deg_to_rad(90)
	else:
		shadow_sprite.global_rotation = global_rotation + (PI / 2)
