class_name WanderState extends State

@export var aggro: Aggro
@export var wander_speed: float = 100.0

var time_to_change_direction: float = 0.0

func _ready():
  if aggro:
    aggro.aggro.connect(_on_aggro)

func enter():
  reset_time_to_change_direction()
  if parent.controls:
    parent.controls.change_direction()
  return null
	
func process_physics(delta):
  if parent.controls:
    var movement_input = parent.controls.get_movement_input()
    parent.apply_acceleration(movement_input, wander_speed)
    parent.clamp_velocity()
    var collision = parent.move_and_slide()
    if collision:
      parent.controls.change_direction()
    if time_to_change_direction < 0:
      reset_time_to_change_direction()
      parent.controls.change_direction()
    time_to_change_direction -= delta
  return null

func reset_time_to_change_direction():
  time_to_change_direction = randf_range(2, 5)

func _on_aggro():
  parent.state_machine.change_state(parent.state_machine.states.get("FollowState"))
