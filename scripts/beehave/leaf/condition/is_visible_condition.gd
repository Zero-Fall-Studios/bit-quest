class_name IsVisibleCondition extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard) -> int:
	if actor.visible:
		return SUCCESS
	return FAILURE
