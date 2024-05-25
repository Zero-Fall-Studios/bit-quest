extends Resource
class_name CharacterSheet

enum CharacterRace { Dwarf, Elf, Halfling, Human, Dragonborn, Gnome, HalfElf, HalfOrc }
enum CharacterClassType { Barbarian, Bard, Cleric, Druid, Fighter, Monk, Paladin, Ranger, Rogue, Sorcerer, Warlock, Wizard }
enum CharacterAlignment { Lawful, Neutral, Chaotic }
enum CharacterAlignmentType { Good, Neutral, Evil }

@export var race : CharacterRace = CharacterRace.Human
@export var class_type : CharacterClassType = CharacterClassType.Fighter
@export var level : int
@export var xp : int
@export var skills = {
	"strength": 0,
	"dexterity": 0,
	"constitution": 0,
	"intelligence": 0,
	"wisdom": 0,
	"charisma": 0
}
@export var alignment : CharacterAlignment = CharacterAlignment.Neutral
@export var alignment_type : CharacterAlignmentType = CharacterAlignmentType.Neutral
