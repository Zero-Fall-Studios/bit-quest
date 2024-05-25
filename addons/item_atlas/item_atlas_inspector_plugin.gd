# my_inspector_plugin.gd
extends EditorInspectorPlugin

var ItemsProperty = preload("res://addons/item_atlas/items_property.gd")

func _can_handle(object):
	return object is ItemAtlas

func _parse_property(object, type, name, hint, hint_text, usage, wide):
	# We handle properties of type integer.
	if name == 'item_index':
		# Create an instance of the custom property editor and register
		# it to a specific property path.
		var editor = ItemsProperty.new()
		editor.set_items_atlas(object)
		add_property_editor(name, editor)
		# Inform the editor to remove the default property editor for
		# this property type.
		return true
	else:
		return false
