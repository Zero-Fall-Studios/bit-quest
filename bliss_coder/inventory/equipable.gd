extends Item
class_name Equipable

enum EquipmentType { None, Head, Neck, Chest, Waist, Legs, Feet, Hand, Finger }

@export var equip_on_pickup: bool = false
@export var equipment_type : EquipmentType = EquipmentType.None

func equip(coords : Vector2):
	PickupSignalBus.equip_event.emit(coords, [self])
	
func unequip(coords : Vector2):
	PickupSignalBus.unequip_event.emit(coords, [self])
