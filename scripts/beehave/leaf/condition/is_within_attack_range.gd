class_name IsWithinAttackRange extends ConditionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.target:
		return SUCCESS
	return FAILURE
