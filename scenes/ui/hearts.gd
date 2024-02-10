extends CanvasLayer

@export var player: Player
@export var heart_texture: Resource

@onready var hearts_container: HBoxContainer = $HeartsContainer

var hearts: Array


func _ready() -> void:
	GameEvents.player_health_changed.connect(_on_player_health_changed)
	
	for i in player.health_component.max_health:
		var heart = TextureRect.new()
		heart.texture = heart_texture
		hearts_container.add_child(heart)
		hearts.append(heart)


func _on_player_health_changed(current_health: int) -> void:
	for i in range(hearts.size()):
		if i < current_health:
			hearts[i].show()
		else:
			hearts[i].hide()
