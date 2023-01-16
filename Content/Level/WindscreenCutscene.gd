extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.dialogue_progress == 5:
		Globals.dialogue_progress = 6
		Globals.disable_walk = true
		
		var k = get_node("../Kitty")
		var f = get_node("../Flag")
		var dn = get_node("../Dragon")
		var d_offset = Vector2(0, -4)
		var time = 1

		var d := DialogueBox.new("Hey flag, do you wanna be friends? :3", d_offset, 0.3, 1.5)
		k.add_child(d)
		yield(d, "tree_exited")

		d = DialogueBox.new("..Uhrm", d_offset, 0.3, time)
		f.add_child(d)
		yield(d, "tree_exited")

		d = DialogueBox.new("..Maybe", d_offset, 0.3, time)
		f.add_child(d)
		yield(d, "tree_exited")

		d = DialogueBox.new("Don't ignore me!!!", d_offset, 0.3, time)
		dn.add_child(d)
		yield(d, "tree_exited")

		Globals.disable_walk = false
