extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var container_node: Node2D = $ContainerNode
@onready var label: Label = $ContainerNode/Label

var is_showing: bool = false

signal interact(node: Node2D)

func _unhandled_input(_event: InputEvent) -> void:
	if is_showing:
		if Input.is_action_just_pressed("interact"):
			interact.emit(self)

func show_ui(pos, message):
	is_showing = true
	label.text = message
	animation_player.play("show")
	position = pos

func hide_ui():
	is_showing = false
	animation_player.play("hide")