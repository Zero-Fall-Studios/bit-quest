extends CharacterBody2D

@export var speed = 100

func _physics_process(_delta):
	var movement_input = get_movement_input()
	velocity = movement_input * speed
	move_and_slide()

func get_movement_input() -> Vector2:
	var input: Vector2 = Vector2.ZERO
	input.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	input.y = (Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	return input.normalized()
