class_name Character extends CharacterBody2D

@export_group("Movement Physics")
@export var max_speed: float = 300.0
@export var acceleration: float = 50.0
@export var friction: float = 70.0

@export_group("Character Sheet")
@export var character_sheet: CharacterSheet = CharacterSheet.new()

@export_group("Spawning")
@export var spawn_position: Node2D

@onready var controls: CharacterControls = $Controls
@onready var state_machine: StateMachine = $StateMachine
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var target_in_range: TargetInRange = $TargetInRange

signal on_spawn(c: Character, pos)
signal on_die(c: Character, pos)

var target
var targets = []
var is_alive: bool = false
var is_paralyzed: bool = false
var aggro: bool = false

func _ready():
	hide()
	is_alive = false
	is_paralyzed = true
	if state_machine:
		state_machine.init(self)

	DialogueScript.action_completed.connect(_on_action_completed)

func _on_action_completed(_choice_index, action_name):
	if action_name == "alignment_evil":
		character_sheet.alignment = CharacterSheet.CharacterAlignment.Evil
		return

func _unhandled_input(event):
	if is_paralyzed:
		return
	if state_machine:
		state_machine.process_input(event)

func _physics_process(delta):
	if state_machine:
		state_machine.process_physics(delta)

func _process(delta):
	if state_machine:
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
	character_sheet.reset()
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
	character_sheet.hp -= damage
	if character_sheet.hp <= 0:
		die()

func take_damage_from_node(actor):
	take_damage(actor.character_sheet.attack)

func handle_collisions_from_slide():
	var collision = get_last_slide_collision()
	var collider = collision.get_collider()
	if collider.is_in_group("enemy"):
		take_damage_from_node(collider)
