extends Node

func _ready():
	if Globals.dialogue_progress == 1:
		Globals.dialogue_progress = 2
		Globals.disable_walk = true
		
		var k = get_node("../Kitty")
		var f = get_node("../Flag")
		var d_offset = Vector2(0, -4)
		
		var d := DialogueBox.new("Hehe, I bet you can't catch me without getting all wet!", d_offset)
		f.add_child(d)
		yield(d, "tree_exited")
