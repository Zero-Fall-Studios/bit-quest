class_name SceneManagerGotoSceneAction extends ActionLeaf

@export var path: String

func tick(actor: Node, _blackboard: Blackboard) -> int:
	SceneManager.goto_scene(path)
	return SUCCESS
