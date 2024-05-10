@tool

class_name Character extends CharacterBody2D

@export_group("Movement Physics")
@export var max_speed: float = 300.0
@export var acceleration: float = 50.0
@export var friction: float = 70.0

@export_group("Stats")
@export var character_stats: CharacterStats

@onready var controls: CharacterControls = $Controls
@onready var state_machine: StateMachine = $StateMachine
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal on_spawn(c: Character, pos)
signal on_die(c: Character, pos)

var target
var is_alive: bool = false
var is_paralyzed: bool = false

func _ready():
	if Engine.is_editor_hint():
		return
	hide()
	is_alive = false
	is_paralyzed = true
	state_machine.init(self)

func _has_controls():
	for child in get_children():
		if child is CharacterControls and child.name == "Controls":
			return true
	return false

func _has_state_machine():
	for child in get_children():
		if child is StateMachine and child.name == "StateMachine":
			return true
	return false

func _get_configuration_warnings():
	var warnings = []

	var has_controls = _has_controls()

	if not has_controls:
		warnings.append("Please assign a `CharacterControls` node to the `Controls` variable.")

	var has_state_machine = _has_state_machine()

	if not has_state_machine:
		warnings.append("Please assign a `StateMachine` node to the `StateMachine` variable.")

	return warnings

func _unhandled_input(event):
	if Engine.is_editor_hint():
		return
	if is_paralyzed:
		return
	state_machine.process_input(event)

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	state_machine.process_physics(delta)

func _process(delta):
	if Engine.is_editor_hint():
		return
	state_machine.process_frame(delta)

func apply_acceleration(direction: Vector2, speed: float):
	if direction.length() > 0:
		velocity = velocity.move_toward(direction.normalized() * speed, acceleration)

func apply_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func clamp_velocity():
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)

func freeze():
	velocity = Vector2.ZERO

func spawn(pos: Vector2):
	character_stats.reset()
	velocity = Vector2.ZERO
	position = pos
	is_alive = true
	is_paralyzed = false
	show()
	on_spawn.emit(self, pos)

func die():
	hide()
	is_alive = false
	is_paralyzed = true
	on_die.emit(self, position)

func take_damage(damage: int):
	character_stats.hp -= damage
	if character_stats.hp <= 0:
		die()

func take_damage_from_node(actor):
	take_damage(actor.character_stats.attack)

func handle_collisions_from_slide():
	var collision = get_last_slide_collision()
	var collider = collision.get_collider()
	if collider.is_in_group("enemy"):
		take_damage_from_node(collider)