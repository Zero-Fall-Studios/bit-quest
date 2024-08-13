extends Node2D

@export var label: Label

var parent

func _ready() -> void:
	parent = get_parent()
	parent.character_sheet.on_alignment_change.connect(_on_alignment_change)
	label.hide()

func _on_alignment_change(_alignment: float) -> void:
	var heat = parent.character_sheet.get_heat()
	if (heat > 0):
		var heat_stars = parent.character_sheet.get_heat_stars()
		label.text = heat_stars
		label.show()
	else:
		label.hide()
