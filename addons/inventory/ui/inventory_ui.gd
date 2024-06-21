@tool
extends Control
class_name InventoryUI

@export var inventory: Inventory
@export var equipment: Equipment
@export var slot: PackedScene
@export var draggable_item_scene: PackedScene

@onready var container: VBoxContainer = $Panel/VBoxContainer
@onready var money_label: Label = $Panel/Label

var inventory_grid: Vector2
@export var grid: Vector2:
	get:
		return inventory_grid
	set(value):
		if value != inventory_grid:
			inventory_grid = value
			_create_grid()
		
func _ready():
	inventory.inventory_change.connect(_on_inventory_change)
	inventory.money_change.connect(_on_money_change)
	equipment.equipment_change.connect(_on_equipment_change)
	
#	_create_or_load_save()
	_create_grid()
	
#func _create_or_load_save():
#	if SaveGame.save_exists():
#		save_game = SaveGame.load_savegame() as SaveGame
#		print("money", save_game.inventory.money)
#		_set_money_text(save_game.inventory.money)
#	else:
#		save_game = SaveGame.new()
#		save_game.inventory = inventory
#		save_game.write_savegame()

func _create_grid():
	if not container:
		return
	for child in container.get_children():
		child.queue_free()
	var slot_index = 0
	for i in range(grid.y):
		var row = HBoxContainer.new()
		row.mouse_filter = Control.MOUSE_FILTER_IGNORE
		row.name = "Row" + str(i)
		for j in range(grid.x):
			var col = slot.instantiate()
			col.name = "Row" + str(i) + "Col" + str(j)
			col.slot_index = slot_index
			slot_index += 1
			row.add_child(col)
		container.add_child(row)

func _on_inventory_change():
	call_deferred("_free_inventory")
	
func _free_inventory():
	for item in get_tree().get_nodes_in_group("draggable_item"):
		item.queue_free()
	call_deferred("_create_inventory")
	
func _create_inventory():
	for s in get_tree().get_nodes_in_group("slot"):
		var item = inventory.get_slot(s.slot_index)
		if item:
			var draggable_item = draggable_item_scene.instantiate()
			draggable_item.item = item
			draggable_item.call_deferred("set_sprite_texture", item.texture)
			s.add_child(draggable_item)
			draggable_item.show()
	
func _on_equipment_change():
	print("_on_equipment_change")
	
func _on_money_change(money):
	_set_money_text(money)
	
func _set_money_text(money):
	money_label.text = "Money: " + str(money)
