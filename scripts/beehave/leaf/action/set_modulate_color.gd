class_name SetModulateColor extends ActionLeaf

@export var modulate_color: Color = Color.WHITE
@export var interpolation_time: float = 3.0

func tick(actor: Node, _blackboard: Blackboard) -> int:
  var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
  tween.tween_property(actor.sprite, "modulate", modulate_color, interpolation_time)
  return SUCCESS
