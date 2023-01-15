extends Sprite

export var is_red = true
var history = []

func _ready():
	var level = Globals.get_level()
	level.init_object(self)
	
	if is_red:
		add_to_group("red_barrier")
		add_to_group("barrier")
	else:
		add_to_group("blue_barrier")
	
	Globals.connect("move_everything", self, "add_history")
	Globals.connect("go_back", self, "undo_history")

func change_state(add_history = true):
	if is_in_group("barrier"):
		remove_from_group("barrier")
		frame = 0
	else:
		add_to_group("barrier")
		frame = 1
	
	if add_history:
		history[history.size() - 1].add_action(funcref(self,"change_state"), [false])

func add_history():
	var h = TurnHistory.new([], [], self)
	history.append(h)

func undo_history():
	if history:
		var h = history.pop_back()
		h.go_back()
