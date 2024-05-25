extends Panel

func _unhandled_input(_event):
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_button_pressed():
	get_tree().quit()
