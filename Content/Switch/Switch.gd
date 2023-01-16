extends Sprite

var blue_sprite = preload("res://Content/Switch/switch_blue.png")
var red_sprite = preload("res://Content/Switch/switch_red.png")

export var is_red = true
var pressed = false
var history = []

var time = 0

func change_state(add_history = true):
	pressed = !pressed
	if pressed: frame = 1
	else: frame = 0
	if add_history:
		history[history.size() - 1].add_action(funcref(self,"change_state"), [false])
	Globals.get_level().is_state_red = is_red && pressed or !is_red and !pressed

func _ready():
	if !Engine.editor_hint:
		var level = Globals.get_level()
		level.init_object(self)
		if is_red:
			add_to_group("red_switch")
			pressed = true
			frame = 1
		else:
			add_to_group("blue_switch")
	Globals.connect("move_everything", self, "add_history")
	Globals.connect("go_back", self, "undo_history")

func add_history():
	var h = TurnHistory.new([], [], self)
	history.append(h)

func undo_history():
	if history:
		var h = history.pop_back()
		h.go_back()

func undo_history_without_deletion():
	pass
