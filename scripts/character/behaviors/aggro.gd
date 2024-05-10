class_name Aggro extends Node

@export var group = "player"
@export var distance = 50
@export var lock_on = false

var parent: Character

signal aggro()
signal deaggro()

func _ready():
	parent = get_parent()

func _process(_delta):
	if parent.target and (not parent.target.is_inside_tree() or not parent.target.is_alive):
		parent.target = null
	var nodes = get_tree().get_nodes_in_group(group)
	for t in nodes:
		if t.is_inside_tree() and t.is_alive:
			if t.position.distance_to(parent.position) < distance:
				parent.target = t
				aggro.emit()
				return
	if parent.target and not lock_on:
		parent.target = null
		deaggro.emit()
