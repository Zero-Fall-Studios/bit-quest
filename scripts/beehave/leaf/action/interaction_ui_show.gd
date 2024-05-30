class_name InteractionUIShowAction extends ActionLeaf

@export var message: String = "Press F to interact"
@export var offset: Vector2 = Vector2(0, 0)

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not InteractionUi.is_showing:
		if actor is Node2D:
			InteractionUi.show_ui(actor.position + offset, message)
	return SUCCESS