class_name DialogueAction extends ActionLeaf

@export_file("*.dsf") var dialogue_interaction_path: String = ""

func tick(actor: Node, _blackboard: Blackboard) -> int:

	if not Dialogue.is_playing and not Dialogue.is_finished:
		Dialogue.run(dialogue_interaction_path)
		return RUNNING

	if not actor.target or Dialogue.is_finished:
		Dialogue.stop()
		return SUCCESS

	return RUNNING
