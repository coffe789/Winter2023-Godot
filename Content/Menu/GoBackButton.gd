extends Node2D

signal goback

func _on_Button_button_up():
	emit_signal("goback")

func _ready():
	var lm = get_tree().get_root().get_node("WorldRoot/ViewportContainer/Viewport/LevelManager")
	connect("goback", Globals, "epic_spaghetti_code", [self.get_parent().get_parent()])

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_parent().get_parent().queue_free()
