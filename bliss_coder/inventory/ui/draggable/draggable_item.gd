class_name DraggableItem
extends Area2D

@export var inventory : Inventory
@onready var sprite : Sprite2D = $Sprite2D

var item : Item
var original_position : Vector2
var selected = false
var is_mouse_over = false
var is_over_dropzone = false
var slot_dropzone : Area2D
var areas_entered : Array[Area2D]

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	hide()
	
func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("left_click"):
		original_position = global_position
		selected = true	
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if selected:
				selected = false
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
				if areas_entered.size() > 0:
					slot_dropzone = areas_entered[0]
					if slot_dropzone:
						if not inventory.set_slot(slot_dropzone.get_slot_index(), item):
							global_position = original_position
						else:
							hide()
				else:
					global_position = original_position
				areas_entered.clear()

func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	is_mouse_over = true

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	is_mouse_over = false
	
func _on_area_entered(area: Area2D):
	if area.is_in_group("dropzone"):
		areas_entered.push_front(area)
		
func _on_area_exited(_area: Area2D):
	areas_entered.pop_back()
	
func _physics_process(_delta):
	if selected:
		global_position = get_global_mouse_position()
		
func set_sprite_texture(texture):
	if sprite:
		sprite.texture = texture
