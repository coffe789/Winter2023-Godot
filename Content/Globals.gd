extends Node

signal move_everything
signal go_back

# Returns null if there's no level
func get_level() -> Level:
	return get_tree().get_nodes_in_group("level").pop_back()

func get_flag() -> Flag:
	return get_tree().get_nodes_in_group("flag").pop_back()

func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("go_back")
