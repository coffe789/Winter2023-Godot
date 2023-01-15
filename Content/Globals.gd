extends Node

signal move_everything
signal go_back

var disabled_input = false # Player input
var dialogue_progress = 0

# Returns null if there's no level
func get_level() -> Level:
	return get_tree().get_nodes_in_group("level").pop_back()

func get_flag() -> Flag:
	var flag =  get_tree().get_nodes_in_group("flag").pop_back()
	if not flag: return get_tree().get_nodes_in_group("dead_flag").pop_back()
	else: return flag

func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("go_back")
