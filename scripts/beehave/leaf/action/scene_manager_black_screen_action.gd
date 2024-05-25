class_name SceneManagerBlackScreenAction extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	SceneManager.show_black_screen()
	if SceneManager.is_playing_animation:
		return RUNNING
	return SUCCESS
