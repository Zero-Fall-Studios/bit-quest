@tool

class_name Character extends CharacterBody2D

@export_group("Movement Physics")
@export var max_speed: float = 300.0
@export var acceleration: float = 50.0
@export var friction: float = 70.0

@onready var controls: CharacterControls = $Controls
@onready var state_machine: StateMachine = $StateMachine

func _ready():
  if Engine.is_editor_hint():
    return
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
  state_machine.process_input(event)

func _physics_process(delta):
  if Engine.is_editor_hint():
    return
  state_machine.process_physics(delta)

func _process_frame(delta):
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
