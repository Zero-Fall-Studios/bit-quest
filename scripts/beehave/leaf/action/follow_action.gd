class_name FollowAction extends ActionLeaf

@export var wait_time: float = 1.0
@export var follow_speed: float = 100.0

var time_passed := 0.0
var has_timer_finished := false

func before_run(actor: Node, blackboard: Blackboard) -> void:
	time_passed = 0.0
	has_timer_finished = false

func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.target == null:
		return FAILURE
	if actor.controls:
		var movement_input = (actor.target.position - actor.position).normalized()
		actor.apply_acceleration(movement_input, follow_speed)
		actor.move_and_slide()
	if has_timer_finished == false:
		time_passed += get_physics_process_delta_time()
		if time_passed >= wait_time:
			return SUCCESS
	return RUNNING
