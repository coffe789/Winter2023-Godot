extends Node

func _ready():
	if Globals.dialogue_progress == 2:
		Globals.dialogue_progress = 3
#		Globals.disable_walk = true
		
		var k = get_node("../Kitty")
		var f = get_node("../Flag")
		var d_offset = Vector2(0, -4)
		
		var d := DialogueBox.new("I can press 'ESC' to undo mistakes..", d_offset)
		k.add_child(d)
		yield(d, "tree_exited")
#		Globals.disable_walk = false
