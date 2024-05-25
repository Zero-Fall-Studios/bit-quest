# my_inspector_plugin.gd
extends EditorInspectorPlugin

var PickupItemEditor = preload("res://addons/pickup/pickup_item_editor.gd")

func _can_handle(object):
	return object is Pickup

func _parse_property(object, type, name, hint, hint_text, usage, wide):
	# We handle properties of type integer.
	if name == 'item_index':
		# Create an instance of the custom property editor and register
		# it to a specific property path.
		if object.item_atlas:
			var editor = PickupItemEditor.new()
			editor.set_items_atlas(object.item_atlas)
			add_property_editor(name, editor)
			# Inform the editor to remove the default property editor for
			# this property type.
			return true
		else:
			return false
	else:
		return false
