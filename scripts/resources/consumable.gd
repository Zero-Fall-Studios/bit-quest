extends Item
class_name Consumable

@export var consume_on_pickup: bool = false

@export_group("Effects")
@export var health : int = 0
@export var speed : int = 0
@export var dexterity : int = 0

func consume(coords : Vector2):
	print("You consumed, ", name)
	print("coords", coords)
	PickupSignalBus.consume_event.emit(coords, [self])
