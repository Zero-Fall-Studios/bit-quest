class_name CharacterSheet extends Resource

enum CharacterRace {Dwarf, Elf, Halfling, Human, Dragonborn, Gnome, HalfElf, HalfOrc}
enum CharacterClassType {Barbarian, Bard, Cleric, Druid, Fighter, Monk, Paladin, Ranger, Rogue, Sorcerer, Warlock, Wizard}

@export_group("Character Type")
@export var race: CharacterRace = CharacterRace.Human
@export var class_type: CharacterClassType = CharacterClassType.Fighter
@export_range(-1.0, 1.0) var alignment: float = 0.0

@export_group("Character Stats")
@export var level: int = 1
@export var hp: int = 1
@export var mp: int = 1
@export var xp: int = 0
@export var strength: int = 1
@export var dexterity: int = 1
@export var constitution: int = 1
@export var intelligence: int = 1
@export var wisdom: int = 1
@export var charisma: int = 1
@export var attack: int = 1

@export_group("Character Starting Stats")
@export var start_level: int = 1
@export var start_hp: int = 1
@export var start_mp: int = 1
@export var start_xp: int = 0
@export var start_strength: int = 1
@export var start_dexterity: int = 1
@export var start_constitution: int = 1
@export var start_intelligence: int = 1
@export var start_wisdom: int = 1
@export var start_charisma: int = 1
@export var start_attack: int = 1

signal on_alignment_change(alignment: float)

func reset():
	level = start_level
	hp = start_hp
	mp = start_mp
	xp = start_xp
	strength = start_strength
	dexterity = start_dexterity
	constitution = start_constitution
	intelligence = start_intelligence
	wisdom = start_wisdom
	charisma = start_charisma
	attack = start_attack

func set_alignment(value: float):
	alignment = clamp(value, -1.0, 1.0)
	on_alignment_change.emit(alignment)

func change_alignment(value: float):
	set_alignment(alignment + value)

func is_good():
	return alignment > 0.3

func is_evil():
	return alignment < - 0.3

func is_neutral():
	return alignment >= - 0.3 and alignment <= 0.3

func get_heat_stars():
	if alignment >= 0:
		return ""
	elif alignment >= - 0.25:
		return "*"
	elif alignment >= - 0.5:
		return "**"
	elif alignment >= - 0.75:
		return "***"
	elif alignment >= - 1:
		return "****"

func get_heat() -> int:
	if alignment >= 0:
		return 0
	elif alignment >= - 0.25:
		return 1
	elif alignment >= - 0.5:
		return 2
	elif alignment >= - 0.75:
		return 3
	elif alignment >= - 1:
		return 4
	return 0