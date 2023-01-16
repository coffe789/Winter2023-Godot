extends Node

func _ready():
	if Globals.dialogue_progress == 4:
		Globals.dialogue_progress = 5
		Globals.disable_walk = true

		var k = get_node("../Kitty")
		var f = get_node("../Flag")
		var dn = get_node("../Dragon")
		var dn2 = get_node("../Dragon2")
		var d_offset = Vector2(0, -4)
		var time = 1
		
		var d := DialogueBox.new("Hahaha! We have your flag", d_offset, 0.5, 1.5)
		dn.add_child(d)
		yield(d, "tree_exited")

		d = DialogueBox.new("Yeah! Now we can like..", d_offset, 0.5, time)
		dn2.add_child(d)
		yield(d, "tree_exited")
		

		d = DialogueBox.new("Wave it or something. IDK", d_offset, 0.5, time)
		dn2.add_child(d)
		yield(d, "tree_exited")
		
		d = DialogueBox.new("hlep", d_offset, 0.5, time)
		f.add_child(d)
		yield(d, "tree_exited")
		Globals.disable_walk = false

		
