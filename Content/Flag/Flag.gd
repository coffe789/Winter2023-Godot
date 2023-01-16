extends Sprite
class_name Flag

func _ready():
	var level = Globals.get_level()
	level.init_object(self)
	add_to_group("flag")
	Globals.connect("go_back", self, "undo_history")

var history = []

func add_history():
	var level = Globals.get_level()
	var grid_pos = level.get_grid_pos(self)
	var h = TurnHistory.new([funcref(level, "send_to_tile")], [[grid_pos, self]], self)
	history.append(h)

func undo_history():
	if history:
		var h = history.pop_back()
		h.go_back()


func undo_history_without_deletion():
	if history:
		var h = history
		h[history.size() - 1].go_back()


func die(death_type : String):
	remove_from_group("flag")
	add_to_group("dead_flag")
	
	Globals.get_level().death_screen()
	
	var last_history = history[history.size()-1]
	last_history.add_action(funcref(self, "revive"),[])
	
	match death_type:
		"spike":
			$Puff.emitting = true
			var ri = randi()%3; match ri:
				0: say("Owww!")
				1: say("I ripped my fabric!")
				2: say("Gah!")

func revive():
	remove_from_group("dead_flag")
	add_to_group("flag")

func say(text : String) -> void:
	var d = DialogueBox.new(text)
	add_child(d)
