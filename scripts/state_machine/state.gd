class_name State extends Node

@export var animation: String
@export var wait_for_animation: bool = false

var parent: Character
var state_machine: StateMachine

func enter() -> void:
  if animation and parent.animation_player != null:
    parent.animation_player.play(animation)
  return

func exit() -> void:
  return

func process_input(_event: InputEvent) -> State:
  return null

func process_frame(_delta: float) -> State:
  return null

func process_physics(_delta: float) -> State:
  return null