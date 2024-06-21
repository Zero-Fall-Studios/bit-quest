class_name CharacterSheet extends Resource

enum CharacterRace {Dwarf, Elf, Halfling, Human, Dragonborn, Gnome, HalfElf, HalfOrc}
enum CharacterClassType {Barbarian, Bard, Cleric, Druid, Fighter, Monk, Paladin, Ranger, Rogue, Sorcerer, Warlock, Wizard}
enum CharacterAlignment {Good, Neutral, Evil}

@export_group("Character Type")
@export var race: CharacterRace = CharacterRace.Human
@export var class_type: CharacterClassType = CharacterClassType.Fighter
@export var alignment: CharacterAlignment = CharacterAlignment.Neutral

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