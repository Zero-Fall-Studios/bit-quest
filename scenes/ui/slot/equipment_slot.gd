@tool
extends Control 
class_name EquipmentSlot

enum EquipmentSlotType
{
	None,
	Helmet,
	Neck,
	Chest,
	Waist,
	Legs,
	Boots,
	Gloves,
	LeftRing,
	RightRing,
	LeftHand,
	RightHand
}

var placeholder_item: Item
@export var placeholder: Item :
	get:
		return placeholder_item
	set(value):
		placeholder_item = value
		if placeholder_texture_rect:
			placeholder_texture_rect.texture = placeholder_item.inventory_sprite
		
var item_data: Item
@export var item: Item :
	get:
		return item_data
	set(value):
		item_data = value
		if item_texture_rect:
			item_texture_rect.texture = item_data.inventory_sprite if item_data else null
		
@export var equipment_slot_type : EquipmentSlotType = EquipmentSlotType.None

@onready var placeholder_texture_rect: TextureRect = $Placeholder
@onready var item_texture_rect: TextureRect = $Item

func _ready():
	if placeholder_item:
		placeholder = placeholder_item
	if item_data:
		item = item_data
	
