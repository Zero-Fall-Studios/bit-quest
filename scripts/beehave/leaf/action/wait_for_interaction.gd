class_name WaitForInterAction extends ActionLeaf

var waiting = false

func before_run(_actor: Node, _blackboard: Blackboard) -> void:
	waiting = true

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.target:
		return FAILURE
	if waiting:
		return RUNNING
	waiting = true
	return SUCCESS

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		waiting = false