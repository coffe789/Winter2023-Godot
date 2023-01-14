extends Node

signal move_everything
signal go_back

# Returns null if there's no level
func get_level() -> Level:
	return get_tree().get_nodes_in_group("level").pop_back()
