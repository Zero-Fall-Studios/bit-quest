class_name Equipment
extends Resource

enum EquipmentSlotType {
	Helmet,
	Neck,
	Chest,
	Waist,
	Legs,
	Boots,
	Gloves,
	LeftFinger,
	RightFinger,
	LeftHand,
	RightHand
}

@export var head: Armor
@export var neck: Armor
@export var chest: Armor
@export var waist: Armor
@export var legs: Armor
@export var feet: Armor
@export var hand: Armor
@export var left_finger: Armor
@export var right_finger: Armor
@export var left_hand: Weapon
@export var right_hand: Weapon

signal equipment_change

func _init():
	call_deferred("_ready")

func _ready():
	print("Equipment ready ...")
	pass
			
func get_slot_type(item: Item):
	if item is Armor:
		var armor = item as Armor
		match armor.equipment_type:
			Armor.EquipmentType.Head:
				return EquipmentSlotType.Helmet
			Armor.EquipmentType.Neck:
				return EquipmentSlotType.Neck
			Armor.EquipmentType.Chest:
				return EquipmentSlotType.Chest
			Armor.EquipmentType.Waist:
				return EquipmentSlotType.Waist
			Armor.EquipmentType.Legs:
				return EquipmentSlotType.Legs
			Armor.EquipmentType.Feet:
				return EquipmentSlotType.Boots
			Armor.EquipmentType.Hand:
				if not left_hand:
					return EquipmentSlotType.LeftHand
				else:
					return EquipmentSlotType.RightHand
			Armor.EquipmentType.Finger:
				if not left_finger:
					return EquipmentSlotType.LeftFinger
				else:
					return EquipmentSlotType.RightFinger
	if item is Weapon:
		var weapon = item as Weapon
		print(weapon)
				
func equip(item: Item, equipment_slot_type: EquipmentSlotType):
	print("Equip")
	match equipment_slot_type:
		EquipmentSlotType.Helmet:
			head = item
		EquipmentSlotType.Neck:
			neck = item
		EquipmentSlotType.Chest:
			chest = item
		EquipmentSlotType.Waist:
			waist = item
		EquipmentSlotType.Legs:
			legs = item
		EquipmentSlotType.Boots:
			feet = item
		EquipmentSlotType.LeftHand:
			left_hand = item
		EquipmentSlotType.RightHand:
			right_hand = item
		EquipmentSlotType.LeftFinger:
			left_finger = item
		EquipmentSlotType.RightFinger:
			right_finger = item
	equipment_change.emit()
	
func unequip(equipment_slot_type: EquipmentSlotType):
	print("UnEquip")
	match equipment_slot_type:
		EquipmentSlotType.Helmet:
			head = null
		EquipmentSlotType.Neck:
			neck = null
		EquipmentSlotType.Chest:
			chest = null
		EquipmentSlotType.Waist:
			waist = null
		EquipmentSlotType.Legs:
			legs = null
		EquipmentSlotType.Boots:
			feet = null
		EquipmentSlotType.LeftHand:
			left_hand = null
		EquipmentSlotType.RightHand:
			right_hand = null
		EquipmentSlotType.LeftFinger:
			left_finger = null
		EquipmentSlotType.RightFinger:
			right_finger = null
	equipment_change.emit()
