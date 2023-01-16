extends Node2D

signal restart

func _on_Button_button_up():
	if not Globals.disable_walk: emit_signal("restart")
#	get_parent().get_parent().queue_free()

func _ready():
	var lm = get_tree().get_root().get_node("WorldRoot/ViewportContainer/Viewport/LevelManager")
	connect("restart", lm, "restart_level", [false])

signal cancelled
func _input(event):
	if event.is_action("ui_cancel"):
		emit_signal("cancelled")

