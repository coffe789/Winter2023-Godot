extends Node2D
class_name Barrier

func _ready():
	var level = Globals.get_level()
	level.init_object(self)
	add_to_group("barrier")

func undo_history():
	pass

func undo_history_without_deletion():
	pass
