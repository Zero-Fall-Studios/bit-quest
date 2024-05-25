extends Node2D

@onready var inventory_ui: InventoryUI = $CanvasLayer/InventoryUI

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		if not inventory_ui.visible:
			inventory_ui.show()
		else:
			inventory_ui.hide()
