extends Node

@export var choice_1 = Label
@export var choice_2 = Label
@export var choice_3 = Label
@export var right_arrow = TextureRect

@onready var canvas_layer = $CanvasLayer
@onready var animation_player = $AnimationPlayer

enum State {
    IDLE,
    SHOWING_UI,
    SHOWING_CHOICES,
    SHOWING_CURSOR,
}

var timer = 0.0
var state = State.IDLE

signal choices_finished(choice_index: int)

var is_running = false
var choice_selected_index = 0
var choices

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		timer = 0.0
	elif state == State.SHOWING_CURSOR:
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
			_on_choice_selected()

func _process(delta):
	if not is_running:
		return
	match state:
		State.IDLE:
			_idle()
		State.SHOWING_UI:
			_showing_ui(delta)
		State.SHOWING_CHOICES:
			_showing_choices(delta)
		State.SHOWING_CURSOR:
			_showing_cursor(delta)

func _idle():
	state = State.SHOWING_UI

func _showing_ui(delta):
	_show_ui()
	state = State.SHOWING_CHOICES
	timer = .25

func _showing_choices(delta):
	timer -= delta
	if timer <= 0.0:
		_show_choices()
		state = State.SHOWING_CURSOR
		timer = .25

func _showing_cursor(delta):
	timer -= delta
	if timer <= 0.0:
		_show_cursor()

func _show_ui():
	choice_1.text = ""
	choice_2.text = ""
	choice_3.text = ""
	animation_player.play("fade_in")

func _hide_ui():
	animation_player.play("fade_out")
	choice_1.text = ""
	choice_2.text = ""
	choice_3.text = ""

func _show_choices() -> void:
	choice_1.text = choices[0]["text"]
	choice_2.text = choices[1]["text"]
	choice_3.text = choices[2]["text"]
	animation_player.play("show_choices")

func _show_cursor():
	animation_player.play("cursor")

func _on_choice_selected():
	stop()
	choices_finished.emit(choice_selected_index)
	
func start(choices_data: Array) -> void:
	choices = choices_data
	is_running = true
	state = State.IDLE

func stop():
	is_running = false
	state = State.IDLE
	_hide_ui()