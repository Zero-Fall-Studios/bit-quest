class_name SceneManagerFadeInAction extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	SceneManager.fade_in()
	if SceneManager.is_playing_animation:
		return RUNNING
	return SUCCESS
