class_name SpawnState extends State

@export var next_state: State
@export var group: String

func enter():
  super.enter()
  var spawn = get_tree().get_first_node_in_group(group)
  if spawn:
    parent.spawn(spawn.position)

func process_frame(_delta: float) -> State:
  if wait_for_animation and parent.animation_player.is_playing():
    return null
  return next_state
