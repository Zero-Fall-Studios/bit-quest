extends EditorProperty

# The main control for editing the property.
var property_control = ItemList.new()
# An internal value of the property.
var current_value = 0
# A guard against internal changes when the property is updated.
var updating = false

func _init():
	pass

func _update_property():
	# Read the current value from the property.
	var new_value = get_edited_object()[get_edited_property()]
	
	# Update the control with the new value.
	updating = true
	current_value = new_value
	if current_value:	
		property_control.select(current_value)
	updating = false
	
func _on_option_selected(index):
	emit_changed(get_edited_property(), index)
	
func set_items_atlas(item_atlas: ItemAtlas):
	property_control.select_mode = ItemList.SELECT_SINGLE
	property_control.custom_minimum_size = Vector2(150, 200)	
	property_control.item_selected.connect(_on_option_selected)
	
	# Add the control as a direct child of EditorProperty node.
	add_child(property_control)
	# Make sure the control is able to retain the focus.
	add_focusable(property_control)
	
	var items = ItemAtlas.create_items(item_atlas)

	for item in items:
		property_control.add_item(item.name, item.texture)
		
	property_control.select(current_value)
