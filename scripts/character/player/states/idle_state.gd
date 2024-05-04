class_name IdleState extends State

func process_physics(_delta: float) -> State:
  if parent.controls:
    var movement_input = parent.controls.get_movement_input()
    if movement_input.length() > 0.0:
      if parent.controls.is_running():
        return state_machine.states.get("RunState")
      return state_machine.states.get("WalkState")
      
  parent.apply_friction()
  parent.clamp_velocity()
  parent.move_and_slide()
  return null