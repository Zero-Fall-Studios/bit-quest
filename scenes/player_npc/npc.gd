extends CharacterBody2D

@export var speed = 100
@export var argo_distance = 50

var direction: Vector2 = Vector2.ZERO
var target: CharacterBody2D

func _physics_process(_delta):
  var movement_input = get_movement_input()
  velocity = movement_input * speed
  if move_and_slide():
    direction = Vector2.ZERO

func get_movement_input():
  calculate_direction()
  detect_target()
  follow_target()
  return direction
  
func calculate_direction():
  if direction == Vector2.ZERO:
    direction = Vector2(randf_range( - 1, 1), randf_range( - 1, 1)).normalized()

func detect_target():
  var players = get_tree().get_nodes_in_group("player")
  for t in players:
    if t.position.distance_to(position) < argo_distance:
      target = t
      return

  if target:
    target = null
    direction = Vector2.ZERO

func follow_target():
  if target == null:
    return
  direction = (target.position - position).normalized()