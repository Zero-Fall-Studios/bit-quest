class_name TargetInRange extends Node

@export var group = "player"
@export var distance = 50

var parent: Character
var targets = []

signal in_range(node: Node2D)
signal out_of_range()

func _ready():
	parent = get_parent()

func _process(_delta):
	_load_targets()

	if parent.target and (not parent.target.is_inside_tree() or not parent.target.is_alive):
		parent.target = null

	for t in targets:
		if t.is_inside_tree() and t.is_alive:
			if t.position.distance_to(parent.position) < distance:
				parent.target = t
				in_range.emit(t)
				return
	
	if parent.target:
		parent.target = null
		out_of_range.emit()

func _load_targets():
	if targets.size() == 0:
		targets = get_tree().get_nodes_in_group(group)
