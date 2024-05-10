class_name WanderAction extends ActionLeaf

@export var wander_speed: float = 100.0
@export var wait_time: float = 1.0

var time_passed := 0.0
var has_timer_finished := false

func before_run(actor: Node, blackboard: Blackboard) -> void:
	time_passed = 0.0
	has_timer_finished = false
	if actor.controls:
		actor.controls.change_direction()

func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.target:
		return FAILURE
	if actor.controls:
		actor.apply_acceleration(actor.controls.get_movement_input(), wander_speed)
		actor.clamp_velocity()
		if actor.move_and_slide():
			actor.controls.change_direction()
	if has_timer_finished == false:
		time_passed += get_physics_process_delta_time()
		if time_passed >= wait_time:
			return SUCCESS
	return RUNNING
