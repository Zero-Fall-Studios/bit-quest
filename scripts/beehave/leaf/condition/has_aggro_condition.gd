class_name HasAggroCondition extends ConditionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.aggro:
		return SUCCESS
	return FAILURE
