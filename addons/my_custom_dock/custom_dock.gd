@tool
extends EditorPlugin

#var Armor = preload("res://resources/armor.gd")
#var Weapon = preload("res://resources/weapon.gd")
#var Consumable = preload("res://resources/consumable.gd")

# A class member to hold the dock during the plugin life cycle.
var dock

func _enter_tree():
	# Initialization of the plugin goes here.
	# Load the dock scene and instantiate it.
	dock = preload("res://addons/my_custom_dock/my_dock.tscn").instantiate()

	# Add the loaded scene to the docks.
	add_control_to_dock(DOCK_SLOT_LEFT_UL, dock)
	# Note that LEFT_UL means the left of the editor, upper-left dock.
	
#	dock.get_node("HBoxContainer/NewArmorButton").pressed.connect(_on_armor_pressed)
#	dock.get_node("HBoxContainer/NewWeaponButton").pressed.connect(_on_weapon_pressed)
#	dock.get_node("HBoxContainer/NewConsumableButton").pressed.connect(_on_consumable_pressed)
	dock.get_node("CreateItemsButton").pressed.connect(_on_items_create_pressed)

func _exit_tree():
	# Clean-up of the plugin goes here.
	# Remove the dock.
	remove_control_from_docks(dock)
	# Erase the control from the memory.
	dock.free()

#func _on_armor_pressed():
#	ResourceSaver.save(Armor.new(), "res://examples/armor/new_armor.tres")
#
#func _on_weapon_pressed():
#	ResourceSaver.save(Weapon.new(), "res://examples/weapons/new_weapon.tres")
#
#func _on_consumable_pressed():
#	ResourceSaver.save(Consumable.new(), "res://examples/consumables/new_consumable.tres")
	
func _on_items_create_pressed():
	var text_field = dock.get_node("CreateItemsFilePath") as TextEdit
	var text = text_field.get_line(0)
	var file = FileAccess.open(text, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(content)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_ARRAY:
			
			
			var index = 0
			for item in data_received:
				var atlas = _create_atlas_from_index("res://assets/images/WeaponsAndArmor.png", index)
				
				index += 1

#				match i.type:
#					"Armor":
				var armor = Armor.new()
				armor.id = item.id
				armor.name = item.name
				armor.texture = atlas
				var file_path = "res://examples/armor/" + item.name + ".tres"
				ResourceSaver.save(armor, file_path)
#					"MeleeWeapon":
#						var weapon = Weapon.new()
#						weapon.name = i.name
#						weapon.texture = atlas
#						var file_path = "res://examples/weapons/silver_axe.tres"
#						ResourceSaver.save(weapon, file_path)
#					"Consumable":
#						var consumable = Consumable.new()
#						consumable.name = i.name
#						consumable.texture = atlas
#						var file_path = "res://examples/weapons/silver_axe.tres"
#						ResourceSaver.save(consumable, file_path)

		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", content, " at line ", json.get_error_line())
		
func _create_atlas_from_index(src, index):
	var atlas = AtlasTexture.new()
	atlas.atlas = load(src)
	
	var coords = get_coords(index, 16, 8, 2)

	var x = coords.x
	var y = coords.y
	var w = 16
	var h = 16

	atlas.region = Rect2(x, y, w, h)
	return atlas
	
func get_coords(index: int, increment: int, w: int, h: int) -> Vector2:
	# Calculating row and col in the 2D array
	var row = int((index) / w)
	var col = (index) % w

	# Converting to x, y coords
	var x = col * increment
	var y = row * increment

	return Vector2(x, y)
