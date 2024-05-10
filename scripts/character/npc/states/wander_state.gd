class_name WanderState extends State

@export var aggro: Aggro
@export var wander_speed: float = 100.0

var wait_time := 1.0
var time_passed := 0.0
var has_timer_finished := false

func _ready():
	if aggro:
		aggro.aggro.connect(_on_aggro)
	
func enter():
	time_passed = 0.0
	has_timer_finished = false
	if parent.controls:
		parent.controls.change_direction()

func process_frame(delta):
	if has_timer_finished == false:
		time_passed += delta
		if time_passed >= wait_time:
			has_timer_finished = true
			parent.state_machine.change_state(parent.state_machine.states.get("NpcIdleState"))

func process_physics(_delta):
	if parent.controls:
		parent.apply_acceleration(parent.controls.get_movement_input(), wander_speed)
		parent.clamp_velocity()
		parent.move_and_slide()
	return null

func _on_aggro():
	parent.state_machine.change_state(parent.state_machine.states.get("FollowState"))
