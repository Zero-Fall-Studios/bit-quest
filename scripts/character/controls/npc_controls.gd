class_name NPCControls extends CharacterControls

@export var argo_distance = 50

var direction: Vector2 = Vector2.ZERO
var target: Character
var parent: Character

func _ready():
  parent = get_parent()

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
    if t.position.distance_to(parent.position) < argo_distance:
      target = t
      return

  if target:
    target = null
    direction = Vector2.ZERO

func follow_target():
  if target == null:
    return
  direction = (target.position - parent.position).normalized()