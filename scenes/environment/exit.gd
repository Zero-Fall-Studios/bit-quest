class_name Exit extends Area2D

signal exit_entered(body: Node2D)

func _on_body_entered(body: Node2D):
	if body is Character:
		#print("body entered", body.name, name)
		exit_entered.emit(body)
