class_name WalkState extends State

@export var walk_speed: float = 100.0

func process_physics(_delta: float) -> State:
  if parent.controls:
    var movement_input = parent.controls.get_movement_input()
    if movement_input.length() == 0.0:
      return state_machine.states.get("IdleState")
    if parent.controls.is_running():
      return state_machine.states.get("RunState")

    parent.apply_acceleration(movement_input, walk_speed)

  parent.clamp_velocity()
  if parent.move_and_slide():
    parent.handle_collisions_from_slide()

  return null