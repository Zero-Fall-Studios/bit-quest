class_name HasTargetCondition extends ConditionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.target:
		return SUCCESS
	return FAILURE
