extends Resource
class_name Item

@export var id: String
@export var name: String
@export var type: String
@export var texture: Texture
@export var is_unique: bool = false
@export var stack_amount: int = 1
@export var quantity: int = 1

@export_group("Modifiers")
@export var skill_modifiers = {
	"strength": 0,
	"dexterity": 0,
	"constitution": 0,
	"intelligence": 0,
	"wisdom": 0,
	"charisma": 0
}
