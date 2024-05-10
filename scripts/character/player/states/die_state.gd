class_name DieState extends State

func process_physics(_delta: float) -> State:
  return state_machine.states.get("SpawnState")
