class_name StateMachine extends Node

@export var initial_state: State

var current_state: State
var previous_state: State
var states: Dictionary = {}

func init(parent) -> void:
  for child in get_children():
    if child is State:
      child.parent = parent
      child.state_machine = self
      states[child.name] = child

  if initial_state:
    change_state(initial_state)

func change_state(state: State) -> void:
  if current_state:
    current_state.exit()

  previous_state = current_state
  current_state = state
  current_state.enter()

func process_input(event: InputEvent) -> void:
  if current_state:
    var state = current_state.process_input(event)
    if state:
      change_state(state)

func process_frame(delta: float) -> void:
  if current_state:
    var state = current_state.process_frame(delta)
    if state:
      change_state(state)

func process_physics(delta: float) -> void:
  if current_state:
    var state = current_state.process_physics(delta)
    if state:
      change_state(state)
