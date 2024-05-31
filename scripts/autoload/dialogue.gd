extends Node

@export var speaker_name = Label
@export var speaker_text = Label

@export var choice_1 = Label
@export var choice_2 = Label
@export var choice_3 = Label

@export var right_arrow = TextureRect

@onready var canvas_layer = $CanvasLayer

@onready var animation_player = $AnimationPlayer

var is_playing = false
var is_finished = false

var current_index = 0
var typing_speed = 0.05
var show_next = false
var is_showing_choices = false
var choice_selected_index = 0
var current_dialog_index = 0
var dialogue_data
var current_scene_name = "Scene 1"

func _unhandled_input(_event: InputEvent) -> void:
	if is_playing and Input.is_action_just_pressed("interact"):
		animation_player.advance(1)
	elif is_showing_choices:
		if Input.is_action_just_pressed("ui_up"):
			right_arrow.position.y -= 25
			choice_selected_index -= 1
			if choice_selected_index < 0:
				right_arrow.position.y += 75
				choice_selected_index = 2
		elif Input.is_action_just_pressed("ui_down"):
			right_arrow.position.y += 25
			choice_selected_index += 1
			if choice_selected_index > 2:
				right_arrow.position.y -= 75
				choice_selected_index = 0
		elif Input.is_action_just_pressed("ui_accept"):
			_on_choice_selected(choice_selected_index)

func show_ui():
	speaker_name.text = ""
	speaker_text.text = ""
	animation_player.play("fade_in")
	await animation_player.animation_finished

func hide_ui():
	animation_player.play("fade_out")
	await animation_player.animation_finished
	choice_1.text = ""
	choice_2.text = ""
	choice_3.text = ""
	speaker_name.text = ""
	speaker_text.text = ""

func show_dialogues(dialogues: Array) -> void:
	is_playing = true
	is_finished = false
	await show_ui()
	choice_1.text = ""
	choice_2.text = ""
	choice_3.text = ""
	for dialogue in dialogues:
		for text in dialogue["text"]:
			speaker_name.text = dialogue["speaker"] + ":"
			speaker_text.text = text
			animation_player.play("speak")
			await animation_player.animation_finished
	await hide_ui()
	print("show_dialogues finished")
	is_playing = false
	is_finished = true
		
func show_choices(choices: Array) -> void:
	is_showing_choices = true
	speaker_name.text = ""
	speaker_text.text = ""
	choice_1.text = choices[0]["text"]
	choice_2.text = choices[1]["text"]
	choice_3.text = choices[2]["text"]
	animation_player.play("show_choices")
	await animation_player.animation_finished
	animation_player.play("cursor")

func stop():
	is_playing = false
	is_finished = true
	animation_player.play("fade_out")
	await animation_player.animation_finished
	choice_1.text = ""
	choice_2.text = ""
	choice_3.text = ""
	speaker_name.text = ""
	speaker_text.text = ""

func run_choices():
	var current_choices = get_current_choices()
	if current_choices.size() > 0:
		await show_choices(current_choices)

func run_actions():
	var current_actions = get_current_actions()
	print("current_actions", current_actions)

func run_dialogue():
	var current_speaker = get_current_speaker()
	var current_text = get_current_text()
	await show_dialogues([{"text": current_text, "speaker": current_speaker, "duration": 1}])
	await run_choices()
	
	var current_actions = get_current_actions()
	if current_actions.size() > 0:
		await run_actions()
		stop()
		return

	var next_scene_name = get_next_scene_name()
	if next_scene_name:
		current_scene_name = next_scene_name
		current_dialog_index = 0
		await run_choices()
	
	if not is_showing_choices and not is_finished:
		stop()

func run(file_path):
	dialogue_data = DialogueParser.parse_by_file_name(file_path)
	is_playing = true
	is_finished = false
	await show_ui()
	run_dialogue()
	
func find_scene(scene_name) -> Dictionary:
	if dialogue_data.size() > 0:
		for dialogue in dialogue_data:
			if dialogue["name"] == scene_name:
				return dialogue
	return {}

func get_current_scene():
	return find_scene(current_scene_name)

func get_current_dialogue():
	return get_current_scene()["dialogue"][current_dialog_index]

func get_next_dialogue():
	if get_current_scene()["dialogue"].has(current_dialog_index + 1):
		return get_current_scene()["dialogue"][current_dialog_index + 1]
	return null

func get_next_scene_name():
	if get_current_dialogue().has("next_scene"):
		return get_current_dialogue()["next_scene"]
	return null

func get_current_speaker():
	return get_current_dialogue()["speaker"]

func get_current_text():
	return get_current_dialogue()["text"]

func get_current_choices():
	if not get_current_dialogue().has("choices"):
		return []
	return get_current_dialogue()["choices"]

func get_current_actions():
	if not get_current_dialogue().has("actions"):
		return []
	return get_current_dialogue()["actions"]

func _on_choice_selected(choice_index: int):
	is_showing_choices = false
	var current_choices = get_current_choices()
	var selected_choice = current_choices[choice_index]
	var next_scene_name = selected_choice["next_scene"]
	current_scene_name = next_scene_name
	current_dialog_index = 0
	run_dialogue()