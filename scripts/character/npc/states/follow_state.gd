class_name FollowState extends State

@export var aggro: Aggro
@export var follow_speed: float = 150.0

# func _ready():
#   if aggro:
#     aggro.deaggro.connect(_on_deaggro)

# func process_physics(_delta: float) -> State:
#   if parent.controls:
#     var movement_input = (aggro.target.position - parent.position).normalized()
#     parent.apply_acceleration(movement_input, follow_speed)
#     parent.move_and_slide()
#   return null

# func _on_deaggro():
#   parent.state_machine.change_state(parent.state_machine.states.get("WanderState"))
