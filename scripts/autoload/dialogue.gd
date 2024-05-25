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
var stop_dialogue = false
var current_scene = "Scene 1"
var is_showing_choices = false
var choice_selected_index = 0
var initial_scene_name = "Scene 1"
var current_dialog_index = 0
var dialogue_data
var current_scene_name = initial_scene_name

func _ready() -> void:
	animation_player.play("fade_out")
	canvas_layer.hide()

func _unhandled_input(_event: InputEvent) -> void:
	if is_playing and Input.is_action_just_pressed("interact"):
		animation_player.seek(animation_player.current_animation_length)
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

func show_dialogues(dialogues: Array) -> void:
	is_playing = true
	is_finished = false
	show_next = false
	stop_dialogue = false
	speaker_name.text = ""
	speaker_text.text = ""
	canvas_layer.show()
	animation_player.play("fade_in")
	await animation_player.animation_finished

	for dialogue in dialogues:

		speaker_name.text = dialogue["speaker"] + ":"
		speaker_text.text = dialogue["text"]

		animation_player.play("speak")
		await animation_player.animation_finished
		
		if stop_dialogue:
			break
		await get_tree().create_timer(dialogue["duration"]).timeout
	animation_player.play("fade_out")
	await animation_player.animation_finished
	is_playing = false
	is_finished = true
	show_next = false
	speaker_name.text = ""
	speaker_text.text = ""

func show_choices(choices: Array) -> void:
	is_playing = true
	is_finished = false
	show_next = false
	stop_dialogue = false
	speaker_name.text = ""
	speaker_text.text = ""
	canvas_layer.show()
	animation_player.play("fade_in")
	await animation_player.animation_finished

	choice_1.text = choices[0]["text"]
	choice_2.text = choices[1]["text"]
	choice_3.text = choices[2]["text"]

	animation_player.play("show_choices")
	await animation_player.animation_finished

	animation_player.play("cursor")

	is_showing_choices = true

func stop():
	stop_dialogue = true
	animation_player.stop()

func run(data):
	dialogue_data = data
	var current_speaker = get_current_speaker()
	var current_text = get_current_text()
	print("current_text", current_text)
	print("current_speaker", current_speaker)
	await show_dialogues([{"text": current_text, "speaker": current_speaker, "duration": 1}])

	var current_choices = get_current_choices()
	print("current_choices", current_choices)
	if current_choices.size() > 0:
		await show_choices(current_choices)

	var has_next_dialog = get_next_dialogue()

	print("has_next_dialog", has_next_dialog)

	# if has_next_dialog:
	# 	current_dialog_index += 1
	# 	run()
	# else:
	# 	has_completed = true
	# 	stop()

func show_next_dialogue() -> void:
	for scene in dialogue_data:
			if scene["name"] == current_scene:
					var entries: Array[Dictionary] = scene["dialogue"]
					if current_index < entries.size():
							var entry: Dictionary = entries[current_index]
							print("%s: %s" % [entry["speaker"], entry["text"]])
							for i in range(entry["choices"].size()):
									print("%d. %s" % [i + 1, entry["choices"][i]["text"]])
							current_index += 1
					else:
							print("End of scene.")
					return

func choose_option(option: int) -> void:
	for scene in dialogue_data:
			if scene["name"] == current_scene:
					var entries: Array[Dictionary] = scene["dialogue"]
					if current_index > 0 and current_index <= entries.size():
							var entry: Dictionary = entries[current_index - 1]
							if option > 0 and option <= entry["choices"].size():
									current_scene = entry["choices"][option - 1]["next_scene"]
									current_index = 0
									show_next_dialogue()
					return

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

func get_current_speaker():
	return get_current_dialogue()["speaker"]

func get_current_text():
	return get_current_dialogue()["text"]

func get_current_choices():
	return get_current_dialogue()["choices"]

func _on_choice_selected(choice_index: int):
	var current_choices = get_current_choices()
	var selected_choice = current_choices[choice_index]
	var next_scene_name = selected_choice["next_scene"]
	current_scene_name = next_scene_name
	current_dialog_index = 0

func has_dialogue():
	return get_current_scene()["dialogue"].size() > 0