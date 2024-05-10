class_name PrintMessageAction extends ActionLeaf

@export var message: String = "Hello World!"

func tick(actor: Node, blackboard: Blackboard) -> int:
	print(message)
	return SUCCESS
