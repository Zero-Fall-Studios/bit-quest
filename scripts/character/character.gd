@tool

class_name Character extends CharacterBody2D

@export var speed = 100
var controls: CharacterControls

func _ready():
  if Engine.is_editor_hint():
    return
  controls = $Controls

func _has_controls():
  for child in get_children():
    if child is CharacterControls and child.name == "Controls":
      return true
  return false

func _get_configuration_warnings():
  var warnings = []

  var has_controls = _has_controls()

  if not has_controls:
    warnings.append("Please assign a `CharacterControls` node to the `Controls` variable.")

  return warnings

func _physics_process(_delta):
  if Engine.is_editor_hint():
    return
  if controls:
    var movement_input = controls.get_movement_input()
    velocity = movement_input * speed
  move_and_slide()