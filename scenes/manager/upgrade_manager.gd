extends Node
class_name UpgradeManager

@export var upgrade_pool: Array[Upgrade]

var projectile_size: float = 1.0
var projectile_speed: float = 1.0
var damage_multiplier: float = 1.0
var move_speed_multiplier: float = 1.0

var current_upgrades: Dictionary = {}

func _ready() -> void:
	var chosen_upgrade = upgrade_pool.pick_random() as Upgrade
	if chosen_upgrade == null:
		return
	
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	
	if !has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			"resource": chosen_upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[chosen_upgrade.id]["quantity"] += 1
	
	print(current_upgrades)
	GameEvents.emit_upgrade_applied(current_upgrades)
