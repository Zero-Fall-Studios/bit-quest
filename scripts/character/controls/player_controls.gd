class_name PlayerControls extends CharacterControls

var parent

func _ready():
	parent = get_parent()

func get_movement_input() -> Vector2:
	if parent.is_paralyzed or not parent.is_alive:
		return Vector2.ZERO
	var input: Vector2 = Vector2.ZERO
	input.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	input.y = (Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	return input.normalized()

func is_running() -> bool:
	if parent.is_paralyzed or not parent.is_alive:
		return false
	return Input.is_action_pressed("run")