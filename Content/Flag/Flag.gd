extends Sprite

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

func _process(_delta):
	var level = Globals.get_level()
	if Input.is_action_just_pressed("ui_right"):
		add_history()
		level.send_in_direction(Vector2.RIGHT, self)
	elif Input.is_action_just_pressed("ui_up"):
		add_history()
		level.send_in_direction(Vector2.UP, self)
	elif Input.is_action_just_pressed("ui_left"):
		add_history()
		level.send_in_direction(Vector2.LEFT, self)
	elif Input.is_action_just_pressed("ui_down"):
		add_history()
		level.send_in_direction(Vector2.DOWN, self)
