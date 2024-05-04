class_name Aggro extends Node

@export var group = "player"
@export var distance = 50
@export var lock_on = false

var target: Character
var parent: Character

signal aggro(target: Character)
signal deaggro(target: Character)

func _ready():
  parent = get_parent()

func _process(_delta):
  if parent:
    detect_target()

func detect_target():
  var nodes = get_tree().get_nodes_in_group(group)
  for t in nodes:
    if t.position.distance_to(parent.position) < distance:
      target = t
      aggro.emit()
      return

  if target and not lock_on:
    target = null
    deaggro.emit()