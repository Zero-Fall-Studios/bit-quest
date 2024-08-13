class_name DialogueScriptAction extends ActionLeaf

@export_file("*.dsf") var dialogue_script_path

func before_run(_actor: Node, _blackboard: Blackboard) -> void:
	DialogueScript.run(dialogue_script_path)

func tick(actor: Node, _blackboard: Blackboard) -> int:

	if not actor.target:
		DialogueScript.stop()
		return FAILURE
		
	if DialogueScript.is_running:
		return RUNNING

	return SUCCESS
