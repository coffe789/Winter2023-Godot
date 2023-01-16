extends Node2D

signal goback

func _on_Button_button_up():
	if not Globals.disable_walk: emit_signal("goback")
	get_parent().get_parent().queue_free()

func _ready():
	var lm = get_tree().get_root().get_node("WorldRoot/ViewportContainer/Viewport/LevelManager")
	connect("goback", Globals, "epic_spaghetti_code", [false])
