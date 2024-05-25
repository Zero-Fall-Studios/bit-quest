class_name SceneManagerFadeInTextAction extends ActionLeaf

@export var text: String

func tick(actor: Node, _blackboard: Blackboard) -> int:
	SceneManager.fade_in_text(text)
	if SceneManager.is_playing_animation:
		return RUNNING
	return SUCCESS
