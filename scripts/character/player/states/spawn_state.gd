class_name SpawnState extends State

@export var next_state: State

func enter():
  super.enter()
  if parent.spawn_position:
    parent.spawn(parent.spawn_position.position)

func process_frame(_delta: float) -> State:
  if wait_for_animation and parent.animation_player.is_playing():
    return null
  return next_state
