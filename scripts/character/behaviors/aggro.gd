class_name Aggro extends Node

@export var target_in_range: TargetInRange
@export var lock_on = false

@export_group("Animations")
@export var animation_on_aggro: String
@export var animation_on_deaggro: String

@export_group("Audio")
@export var audio_on_aggro: AudioStreamPlayer2D
@export var audio_on_deaggro: AudioStreamPlayer2D

var parent: Character
var has_aggro: bool = false

signal aggro()
signal deaggro()

func _ready():
	parent = get_parent()
	target_in_range.in_range.connect(_on_in_range)
	target_in_range.out_of_range.connect(_on_out_of_range)

func _on_in_range(_node: Node2D):
	if not has_aggro:
		has_aggro = true
		if animation_on_aggro:
			parent.animation_player.play(animation_on_aggro)
		if audio_on_aggro:
			audio_on_aggro.play()
		aggro.emit()

func _on_out_of_range():
	if has_aggro:
		has_aggro = false
		if animation_on_deaggro:
			parent.animation_player.play(animation_on_deaggro)
		if audio_on_deaggro:
			audio_on_deaggro.play()
		deaggro.emit()
