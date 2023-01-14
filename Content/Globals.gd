extends Node

signal move_everything

# Returns null if there's no level
func get_level():
	return get_tree().get_nodes_in_group("level").pop_back()
