class_name Exit extends Area2D

signal exit_entered

func _on_body_entered(body: Node2D):
  if body is Character:
    exit_entered.emit()
