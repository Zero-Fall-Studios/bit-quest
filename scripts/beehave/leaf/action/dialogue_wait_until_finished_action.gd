class_name DialogueWaitUntilFinishedAction extends ActionLeaf

func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if not Dialogue.is_finished:
		return RUNNING
	return SUCCESS
