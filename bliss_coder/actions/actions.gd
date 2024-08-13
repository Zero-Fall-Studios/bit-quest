extends Node2D

@export var alignment_timer: Timer

func _ready() -> void:
	DialogueScript.action_completed.connect(_on_dialogue_action_complete)
	PickupSignalBus.pickup_event.connect(_on_pickup_event)

func call_action(action_name: String):
	var player = get_tree().get_first_node_in_group("player")
	if action_name == "alignment_evil":
		player.character_sheet.change_alignment( - 0.25)
		alignment_timer.start()

func _on_pickup_event(_coords: Vector2, _new_items: Array[Item]):
	call_action("alignment_evil")

func _on_dialogue_action_complete(action_name: String):
	call_action(action_name)

func _on_alignment_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	var alignment = player.character_sheet.alignment
	if alignment < 0:
		player.character_sheet.change_alignment(0.25)
	else:
		player.character_sheet.set_alignment(0)
		alignment_timer.stop()
