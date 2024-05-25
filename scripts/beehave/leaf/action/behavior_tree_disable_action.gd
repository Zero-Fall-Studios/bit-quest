class_name BehaviorTreeDisableAction extends ActionLeaf

@export var behavior_tree: BeehaveTree

func tick(actor: Node, _blackboard: Blackboard) -> int:
	behavior_tree.enabled = false
	return SUCCESS
