extends Node2D;
signal cont;
func _on_Button_button_up(): emit_signal("cont")

func _ready():
	Globals.connect("go_back", self, "on_go_back")

func on_go_back():
	Globals.disable_walk = false
	queue_free()

func _input(event):
	if event.is_action("ui_accept"):
		emit_signal("cont")
