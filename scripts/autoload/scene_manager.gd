extends CanvasLayer

@onready var color: ColorRect = $ColorRect
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_scene = null
var level = 0
var is_playing_animation = false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	animation_player.animation_started.connect(_on_animation_started)
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_started():
	is_playing_animation = true

func _on_animation_finished():
	is_playing_animation = false

func fade_in():
	animation_player.play("FadeIn")
	
func fade_out():
	animation_player.play("FadeOut")

func show_black_screen():
	animation_player.play("Black")
	
func fade_in_text(text: String):
	label.text = text
	animation_player.play("FadeInText")
	
func goto_scene(path: String):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
