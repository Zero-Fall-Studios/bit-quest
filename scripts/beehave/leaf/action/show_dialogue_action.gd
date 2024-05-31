class_name ShowDialogueAction extends ActionLeaf

@export var dialogue: String = ""
@export var speaker: String = ""

func tick(actor: Node, _blackboard: Blackboard) -> int:
	
	if not Dialogue.is_playing:
		print("showing dialogue")
		Dialogue.show_dialogues([{"text": [dialogue], "speaker": speaker}])
		print("showing dialogue 2")
		return RUNNING

	if not actor.target or Dialogue.is_finished:
		print("dialogue finished")
		return SUCCESS

	return RUNNING