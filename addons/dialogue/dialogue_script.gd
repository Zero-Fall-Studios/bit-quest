extends Node

var is_running = false
var current_scene_index = 0
var current_dialogue_index = 0
var previous_scene_index = 0
var previous_dialogue_index = 0
var current_choice_index = 0

var dialogues

signal action_completed(choice_index, action_name)

func _ready() -> void:
	Dialogue.complete.connect(_on_dialogue_complete)
	Choices.choices_finished.connect(_on_choices_finished)

func reset():
	current_scene_index = 0
	current_dialogue_index = 0

func run(file_name: String):
	dialogues = DialogueParser.parse_by_file_name(file_name)
	is_running = true
	reset()
	show_dialogue()

func show_dialogue():
	var current_scene = dialogues[current_scene_index]
	var current_dialogues = current_scene["dialogue"]
	var current_dialogue = current_dialogues[current_dialogue_index]
	var current_speaker = current_dialogue["speaker"]
	var current_texts = current_dialogue["text"]
	Dialogue.start(current_texts, current_speaker)

func stop():
	is_running = false
	reset()
	Dialogue.stop()
	Choices.stop()

func find_scene_index_by_name(scene_name: String) -> int:
	for i in dialogues.size():
		var dialogue = dialogues[i]
		if dialogue["name"] == scene_name:
			return i
	return - 1

func _on_dialogue_complete():
	if not is_running:
		return
	var current_scene = dialogues[current_scene_index]
	var current_dialogues = current_scene["dialogue"]
	var current_dialogue = current_dialogues[current_dialogue_index]

	if current_dialogue.has("choices"):
		var current_choices = current_dialogue["choices"]
		if current_choices:
			Choices.start(current_choices)
			return

	if current_dialogue.has("next_scene"):
		var current_dialogue_next_scene = current_dialogue["next_scene"]
		var next_scene_index = find_scene_index_by_name(current_dialogue_next_scene)
		if next_scene_index != - 1:
			previous_scene_index = current_scene_index
			current_scene_index = next_scene_index
			previous_dialogue_index = current_dialogue_index
			current_dialogue_index = 0
			show_dialogue()
			return

	if current_dialogue.has("actions"):
		var current_actions = current_dialogue["actions"]
		for action in current_actions:
			if action == "return_to_choices":
				current_scene_index = previous_scene_index
				current_dialogue_index = 0
				_on_dialogue_complete()
				return
			if action == "alignment_evil":
				action_completed.emit(current_choice_index, "alignment_evil")
				return
	stop()

func _on_choices_finished(choice_index: int):
	if not is_running:
		return

	current_choice_index = choice_index

	var current_scene = dialogues[current_scene_index]
	var current_dialogues = current_scene["dialogue"]
	var current_dialogue = current_dialogues[current_dialogue_index]
	var current_choices = current_dialogue["choices"]

	if current_choices[current_choice_index].has("next_scene"):
		var current_choice_next_scene = current_choices[current_choice_index]["next_scene"]
		var next_scene_index = find_scene_index_by_name(current_choice_next_scene)

		if next_scene_index != - 1:
			previous_scene_index = current_scene_index
			current_scene_index = next_scene_index
			previous_dialogue_index = current_dialogue_index
			current_dialogue_index = 0
			show_dialogue()
