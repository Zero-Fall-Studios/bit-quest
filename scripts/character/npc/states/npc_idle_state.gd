class_name NpcIdleState extends State

@export var aggro: Aggro

var wait_time := 1.0
var time_passed := 0.0
var has_timer_finished := false

func enter():
	time_passed = 0.0
	has_timer_finished = false

func process_frame(delta):
	if has_timer_finished == false:
		time_passed += delta
		if time_passed >= wait_time:
			has_timer_finished = true
			return parent.state_machine.states.get("WanderState")

func _on_aggro():
	parent.state_machine.change_state(parent.state_machine.states.get("FollowState"))
