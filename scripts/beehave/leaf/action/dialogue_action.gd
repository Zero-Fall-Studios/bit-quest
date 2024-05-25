class_name DialogueAction extends ActionLeaf

@export var talk_interaction: TalkInteraction
@export var message: String = "Hello, World!"

func before_run(_actor: Node, _blackboard: Blackboard) -> void:
	if not talk_interaction.has_completed:
		talk_interaction.run()

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.target or Dialogue.is_finished:
		talk_interaction.stop()
		return SUCCESS

	return RUNNING
