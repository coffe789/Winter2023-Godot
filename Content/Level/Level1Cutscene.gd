extends Node


func _ready():
	if Globals.dialogue_progress == 0:
		Globals.dialogue_progress = 1
		Globals.disabled_input = true
		
		var k = get_node("../Kitty")
		var f = get_node("../Flag")
		var d_offset = Vector2(0, -4)
		
		var d := DialogueBox.new("Aha, I have finally found it!", d_offset)
		k.add_child(d)
		$Timer.start(3)
		yield(d, "tree_exited")
		
		d = DialogueBox.new("The end of the level..", d_offset)
		k.add_child(d)
		yield(d, "tree_exited")
		
		d = DialogueBox.new("Who? Me?", d_offset)
		f.add_child(d)
		yield(d, "tree_exited")

		d = DialogueBox.new("!!!", d_offset)
		k.add_child(d)
		yield(d, "tree_exited")

		d = DialogueBox.new("Catch me if you can! Hehe..", d_offset)
		f.add_child(d)
		yield(d, "tree_exited")

		Globals.disabled_input = false
