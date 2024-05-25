class_name Player
extends CharacterBody2D

@onready var trail : Trail = $Trail

@export_group("Movement Physics")
@export var speed : float = 300.0
@export var acceleration : float = 50.0
@export var friction : float = 70.0
@export var ai : bool = false
@export var direction : Vector2 = Vector2.ZERO

@export_group("Apprearance")
@export var color : Color

func _ready():
	if color:
		$Light.modulate = color

func _physics_process(_delta):
	direction = get_input_direction()
	if direction:
		accelerate()
	else:
		apply_friction()

	move_and_slide()

	if ai and get_slide_collision_count() > 0:
		var collide_point = get_last_slide_collision().get_position()
		change_ai_direction(collide_point)

func accelerate():
	velocity = velocity.move_toward(speed * direction, acceleration)

func apply_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func get_input_direction():
	if not ai:
		direction = get_player_direction()
	return direction.normalized()

func get_player_direction():
	var d = Vector2.ZERO
	d.x = Input.get_axis("move_left", "move_right")
	d.y = Input.get_axis("move_up", "move_down")
	return d

func change_ai_direction(collide_position):
	var normal = collide_position.normalized()
	direction = velocity - 2 * (velocity.dot(normal)) * normal
