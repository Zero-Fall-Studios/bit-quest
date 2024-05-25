extends Node

signal pickup_event(coords: Vector2, items: Array[Item])
signal equip_event(coords: Vector2, items: Array[Equipable])
signal unequip_event(coords: Vector2, items: Array[Equipable])
signal consume_event(coords: Vector2, items: Array[Consumable])
