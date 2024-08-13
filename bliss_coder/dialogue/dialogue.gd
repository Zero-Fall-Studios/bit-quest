extends Node

enum State {
    IDLE,
    SHOWING_UI,
    SHOWING_DIALOGUE
}

class DialogueQueue:
	var text: String
	var speaker: String

@export var speaker_name = Label
@export var speaker_text = Label

@onready var canvas_layer = $CanvasLayer
@onready var animation_player = $AnimationPlayer

var timer = 0.0
var state = State.IDLE
var is_running = false
var dialogue_queue: Array[DialogueQueue] = []

signal complete

func _unhandled_input(_event: InputEvent) -> void:
	if is_running and Input.is_action_just_pressed("interact"):
		timer = 0.0

func _process(delta):
	if not is_running:
		return
	match state:
		State.IDLE:
			_idle()
		State.SHOWING_UI:
			_showing_ui(delta)
		State.SHOWING_DIALOGUE:
			_showing_dialogue(delta)

func _idle():
	if dialogue_queue.size() > 0:
		state = State.SHOWING_UI

func _showing_ui(delta):
	_show_ui()
	state = State.SHOWING_DIALOGUE
	timer = .25

func _showing_dialogue(delta):
	timer -= delta
	if timer <= 0.0:
		if dialogue_queue.size() > 0:
			_show_dialogue()
			timer = 1.5
		else:
			stop()

func _show_ui():
	speaker_name.text = ""
	speaker_text.text = ""
	animation_player.play("fade_in")

func _show_dialogue():
	var dialogue = dialogue_queue.pop_front()
	speaker_name.text = dialogue.speaker + ":"
	speaker_text.text = dialogue.text
	animation_player.play("speak")

func _hide_ui():
	if not is_running:
		return
	animation_player.play("fade_out")
	speaker_name.text = ""
	speaker_text.text = ""

func start(text: Array, speaker: String):
	dialogue_queue.clear()
	for t in text:
		var dialogue = DialogueQueue.new()
		dialogue.text = t
		dialogue.speaker = speaker
		dialogue_queue.push_back(dialogue)
	is_running = true

func stop():
	_hide_ui()
	state = State.IDLE
	is_running = false
	complete.emit()