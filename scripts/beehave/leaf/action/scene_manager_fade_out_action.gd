class_name SceneManagerFadeOutAction extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	SceneManager.fade_out()
	if SceneManager.is_playing_animation:
		return RUNNING
	return SUCCESS
