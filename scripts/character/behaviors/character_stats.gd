class_name CharacterStats extends Resource

@export var hp: int = 100
@export var mp: int = 100
@export var xp: int = 0
@export var attack: int = 0
@export var defense: int = 0

@export_group("Starting Values")
@export var starting_hp: int = 100
@export var starting_mp: int = 100
@export var starting_xp: int = 0
@export var starting_attack: int = 0
@export var starting_defense: int = 0

func reset():
    hp = starting_hp
    mp = starting_mp
    xp = starting_xp
    attack = starting_attack
    defense = starting_defense
