class_name TalkInteraction extends Node2D

@export var target_in_range: TargetInRange
@export_file("*.dsf") var dialogue_interaction_path: String = ""

@export var initial_scene_name: String = "Scene 1"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_showing: bool = false
var dialogue_data: Array[Dictionary] = []

func _ready():
	target_in_range.in_range.connect(_on_in_range)
	target_in_range.out_of_range.connect(_on_out_of_range)
	dialogue_data = DialogueParser.parse_by_file_name(dialogue_interaction_path)

func _on_in_range(_node: Node2D):
	if not is_showing:
		is_showing = true
		animation_player.play("show")

func _on_out_of_range():
	if is_showing:
		is_showing = false
		animation_player.play("hide")
	Dialogue.stop()

func _unhandled_input(_event: InputEvent) -> void:
	if is_showing and Dialogue.has_dialogue():
		if Input.is_action_just_pressed("interact"):
			Dialogue.run(dialogue_data)
