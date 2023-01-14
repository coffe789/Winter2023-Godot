extends Sprite
class_name Flag

func _ready():
	var level = Globals.get_level()
	level.init_object(self)
	add_to_group("flag")

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


