extends Node2D

@export var fade_in_title: BeehaveTree
@export var goto_game: BeehaveTree

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_anything_pressed() and not fade_in_title.enabled:
		goto_game.enabled = true
