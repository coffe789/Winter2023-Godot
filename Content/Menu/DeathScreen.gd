extends Node2D

func _input(_e):
	if Input.is_action_just_pressed("undo") or Input.is_action_just_pressed("restart"):
		queue_free()
