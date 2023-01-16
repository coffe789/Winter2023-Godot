extends Node

func _ready():
	if Globals.dialogue_progress == 1:
		Globals.dialogue_progress = 2
		Globals.disable_walk = true
		
		var k = get_node("../Kitty")
		var f = get_node("../Flag")
		var d_offset = Vector2(0, -4)
		
		var d := DialogueBox.new("Hehe, I bet you don't like getting wet!", d_offset, 0.3, 1.0)
		f.add_child(d)
		yield(d, "tree_exited")
		
		Globals.disable_walk = false
