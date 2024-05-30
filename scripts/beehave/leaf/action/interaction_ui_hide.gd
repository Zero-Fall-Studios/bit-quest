class_name InteractionUIHideAction extends ActionLeaf

func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if InteractionUi.is_showing:
		InteractionUi.hide_ui()
	return SUCCESS
