class_name State extends Node

var parent: Character
var state_machine: StateMachine

func enter() -> void:
  return

func exit() -> void:
  return

func process_input(_event: InputEvent) -> State:
  return null

func process_frame(_delta: float) -> State:
  return null

func process_physics(_delta: float) -> State:
  return null