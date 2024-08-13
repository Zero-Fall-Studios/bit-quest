extends Resource
class_name Inventory

@export var money: int = 0
@export var max_slots = 50

var items: Array[Item] = []

signal inventory_change
signal money_change

func _init():
	print("Inventory ready ...")
	items.resize(max_slots)
	items.fill(null)

func get_size():
	return items.size()
	
func add(coords: Vector2, new_items: Array[Item]):
	for item in new_items:
		
		var _item = item.duplicate()

		if in_inventory(_item) and _item.is_unique:
			print("Item is unique")
			continue

		if in_inventory(_item) and _item.is_stackable and _item.quantity < _item.max_stackable_count:
			print("Add quantity")
			add_quantity(_item, _item.quantity)
			continue

		if _item is Equipable:
			var equipable = _item as Equipable
			if equipable.equip_on_pickup:
				equipable.equip(coords)
				continue
		elif _item is Consumable:
			var consumable = _item as Consumable
			if consumable.consume_on_pickup:
				consumable.consume(coords)
				continue
		elif _item is Money:
			var m = _item as Money
			money = money + m.amount
			money_change.emit(money)
			continue
						
		var next_slot = get_next_available_slot()
		if next_slot >= 0:
			set_slot(next_slot, _item)
	
func remove(item: Item):
	items.erase(item)
	inventory_change.emit()

func add_quantity(item: Item, amount: int):
	item.quantity += amount
	if item.quantity <= 0:
		remove(item)
	inventory_change.emit()
	
func add_money(amount: int):
	money += amount
	
func in_inventory(item: Item):
	var index = items.find(func(i): return i.id == item.id)
	return index != - 1
	
func has_item(item: Item):
	var index = items.find(func(i): return i.id == item.id)
	return index != - 1

func get_slot(slot_index) -> Item:
	return items[slot_index]
	
func get_slot_index(item: Item):
	return items.find(item)
	
func set_slot(slot_index, item: Item):
	if items[slot_index] == null:
		var prev_index = get_slot_index(item)
		items[slot_index] = item
		items[prev_index] = null
		inventory_change.emit()
		return true
	return false
	
func remove_slot(slot_index, _item: Item):
	items[slot_index] = null
	inventory_change.emit()
	
func get_next_available_slot():
	for i in items.size():
		if items[i] == null:
			return i
	return - 1
				
func consume(item: Item):
	item.consume()
	if item.is_stackable and item.quantity > 0:
		add_quantity(item, -1)
	else:
		remove(item)
