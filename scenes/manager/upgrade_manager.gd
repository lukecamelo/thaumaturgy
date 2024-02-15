extends Node
class_name UpgradeManager

@export var store_screen_scene: PackedScene
@export var wave_manager: WaveManager

var current_upgrades: Dictionary = {}
var upgrade_pool: WeightedTable =  WeightedTable.new()

var upgrade_bullet_burst = preload("res://resources/upgrades/bullet_burst.tres")
var upgrade_projectile_size = preload("res://resources/upgrades/projectile_size_increase_upgrade.tres")

func _ready() -> void:
	upgrade_pool.add_item(upgrade_bullet_burst, 10)
	upgrade_pool.add_item(upgrade_projectile_size, 10)
	
	GameEvents.wave_cleared.connect(_on_wave_cleared)


func apply_upgrade(upgrade: Upgrade) -> void:
	var has_upgrade = current_upgrades.has(upgrade.id)
	
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		
		if current_quantity == upgrade.max_quantity:
			pass
	
	GameEvents.emit_upgrade_applied(current_upgrades, upgrade)


func pick_upgrades() -> Array[Upgrade]:
	var chosen_upgrades: Array[Upgrade] = []
	
	for i in 2:
		if upgrade_pool.size() == chosen_upgrades.size():
			break
		
		var chosen_upgrade = upgrade_pool.pick_item(chosen_upgrades)
		chosen_upgrades.append(chosen_upgrade)
	
	return chosen_upgrades


# for testing, we won't just give the player a random upgrade when they clear a wave
func _on_wave_cleared() -> void:
	var chosen_upgrade = upgrade_pool.pick_random() as Upgrade
	if chosen_upgrade == null:
		return
	
	apply_upgrade(chosen_upgrade)
	
