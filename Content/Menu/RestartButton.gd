extends Node2D

signal restart

func _on_Button_button_up():
	emit_signal("restart")

func _ready():
	var lm = get_tree().get_root().get_node("WorldRoot/ViewportContainer/Viewport/LevelManager")
	connect("restart", lm, "restart_level", [self.get_parent().get_parent()])

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_parent().get_parent().queue_free()
		Globals.disabled_input = false
