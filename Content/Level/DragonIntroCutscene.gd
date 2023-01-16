extends Node

func _ready():
	if Globals.dialogue_progress == 3:
		Globals.dialogue_progress = 4
		Globals.disable_walk = true
		var time = 1
		
		var k = get_node("../Kitty")
		var f = get_node("../Flag")
		var dn = get_node("../Dragon")
		var d_offset = Vector2(0, -4)
		
		var d := DialogueBox.new("Hehe I'm gonna burn you..", d_offset, 0.3, time)
		dn.add_child(d)
		yield(d, "tree_exited")
		
		d = DialogueBox.new("Hm but which direction should I attack you from?", d_offset, 0.3, time)
		dn.add_child(d)
		yield(d, "tree_exited")

		d = DialogueBox.new("You are a big dragon, decide for yourself", d_offset, 0.3, time)
		f.add_child(d)
		yield(d, "tree_exited")
		
		d = DialogueBox.new("Yeah! :3", d_offset, 0.3, time)
		k.add_child(d)
		yield(d, "tree_exited")

		d = DialogueBox.new("..Okay", d_offset, 0.3, time)
		dn.add_child(d)
		yield(d, "tree_exited")

		Globals.disable_walk = false
