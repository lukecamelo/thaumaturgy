extends Node

@export var sprite: Sprite2D

var afterimage_lifetime = 0.2 # Seconds each afterimage lasts before disappearing
var afterimage_interval = 0.1 # Seconds between creating each afterimage
var timer = 0.0 # Tracks time to next afterimage creation

func _process(delta):
	timer += delta
	if timer >= afterimage_interval:
		timer = 0.0
		create_afterimage()

func create_afterimage():
	var afterimage = sprite.duplicate() # Create a copy of this sprite
	
	afterimage.modulate.a = 0.5 # Start with half opacity or any starting value you prefer
	
	get_tree().root.add_child(afterimage) # Add it to the scene tree
	afterimage.global_position = sprite.global_position
	afterimage.rotation = sprite.rotation + deg_to_rad(90)
	
	var tween = create_tween()
	tween.tween_property(afterimage, "modulate:a", 0, afterimage_lifetime).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(queue_free)
