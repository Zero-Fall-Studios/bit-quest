class_name IsTalkingCondition extends ConditionLeaf

@export var talk_interaction: TalkInteraction

func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if Dialogue.in_process:
		return SUCCESS
	return FAILURE
