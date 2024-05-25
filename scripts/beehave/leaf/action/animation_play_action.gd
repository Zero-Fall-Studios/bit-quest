class_name AnimationPlayAction extends ActionLeaf

@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var wait_until_animation_finished: bool = false

var is_playing_animation: bool = false

func _ready():
	animation_player.animation_started.connect(_on_animation_started)
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_started():
	is_playing_animation = true

func _on_animation_finished():
	is_playing_animation = false

func before_run(_actor: Node, _blackboard: Blackboard) -> void:
	is_playing_animation = false

func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if not is_playing_animation:
		animation_player.play(animation_name)
	if wait_until_animation_finished and is_playing_animation:
		return RUNNING
	return SUCCESS
