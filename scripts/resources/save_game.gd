extends Resource
class_name SaveGame

const SAVE_PATH = "user://save.tres"

@export var inventory: Inventory

func write_savegame():
	pass
#	ResourceSaver.save(self, SAVE_PATH, ResourceSaver.FLAG_BUNDLE_RESOURCES)
	
static func save_exists():
#	return ResourceLoader.exists(SAVE_PATH)
	return false
	
static func load_savegame():
#	return load(SAVE_PATH)
	return	
