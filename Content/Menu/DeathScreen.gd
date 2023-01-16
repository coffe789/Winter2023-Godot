extends Node2D

func _input(_e):
	if Input.is_action_just_pressed("undo"):
		queue_free()
