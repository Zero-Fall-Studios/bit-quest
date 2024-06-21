@tool
extends Resource
class_name ItemAtlas

@export var texture: Texture
@export_file("*.json") var json_src
@export var interval: int = 16
@export var width: int = 1
@export var height: int = 1
@export var item_index: int = 0

var items = []

func get_item_at_index(index: int) -> Item:
	if items != null and items.size() == 0:
		items = ItemAtlas.create_items(self)
		
	if items[index]:
		return items[index]
	
	return null

static func create_items(item_atlas: ItemAtlas):
	var items_to_create = []
	var file = FileAccess.open(item_atlas.json_src, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(content)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_ARRAY:
			var index = 0
			for item in data_received:
				var atlas = ItemAtlas.create_atlas_from_index(item_atlas, index)
				
				index += 1

				match item.type:
					"Armor":
						var armor = Armor.new()
						armor.id = item.id
						armor.name = item.name
						armor.texture = atlas
						items_to_create.append(armor)
					"Money":
						var money = Money.new()
						money.id = item.id
						money.name = item.name
						money.texture = atlas
						items_to_create.append(money)
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
		
	return items_to_create

static func create_atlas_from_index(item_atlas: ItemAtlas, index):
	var atlas = AtlasTexture.new()
	atlas.atlas = item_atlas.texture
	var coords = get_coords(index, item_atlas.interval, item_atlas.width, item_atlas.height)
	var x = coords.x
	var y = coords.y
	var w = item_atlas.interval
	var h = item_atlas.interval
	atlas.region = Rect2(x, y, w, h)
	return atlas
	
static func get_coords(index: int, increment: int, w: int, h: int) -> Vector2:
	# Calculating row and col in the 2D array
	var row = int((index) / w)
	var col = (index) % w
	# Converting to x, y coords
	var x = col * increment
	var y = row * increment
	return Vector2(x, y)
