extends PanelContainer
class_name UpgradeCard

signal selected

@onready var name_label: Label = %Name
@onready var description_label: Label = %Description


func _ready() -> void:
	gui_input.connect(_on_gui_input)


func set_upgrade(upgrade: Upgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func _on_gui_input(event: InputEvent) -> void:
	pass
