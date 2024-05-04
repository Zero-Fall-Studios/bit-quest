class_name NPCControls extends CharacterControls

var direction: Vector2 = Vector2.ZERO

func get_movement_input():
  return direction
  
func change_direction():
  direction = Vector2(randf_range( - 1, 1), randf_range( - 1, 1)).normalized()
