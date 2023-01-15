extends Node2D
class_name Kitty

var history = []

func _ready():
	var level = Globals.get_level()
	level.init_object(self)
	add_to_group("kitty")
	Globals.connect("go_back", self, "undo_history")

func do_turn():
	Globals.emit_signal("move_everything")
	
	var level = Globals.get_level()
	level.resolve_collisions()

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
	remove_from_group("kitty")
	add_to_group("dead_kitty")
	
	var last_history = history[history.size()-1]
	last_history.add_action(funcref(self, "revive"),[])
	
	match death_type:
		"water": $Splash.emitting = true
		"spike": $Splash.emitting = true
	
	visible = false


func revive():
	remove_from_group("dead_kitty")
	add_to_group("kitty")
	
	visible = true


func _process(_delta):
	var level = Globals.get_level()
	var flag = Globals.get_flag()

	if not is_in_group("dead_kitty") and not flag.is_in_group("dead_flag"):
		if Input.is_action_just_pressed("ui_right"):
			flag.add_history()
			add_history()
			level.send_in_direction(Vector2.RIGHT, flag)
			level.send_in_direction(Vector2.RIGHT, self)
			do_turn()
		elif Input.is_action_just_pressed("ui_up"):
			flag.add_history()
			add_history()
			level.send_in_direction(Vector2.UP, flag)
			level.send_in_direction(Vector2.UP, self)
			do_turn()
		elif Input.is_action_just_pressed("ui_left"):
			flag.add_history()
			add_history()
			level.send_in_direction(Vector2.LEFT, flag)
			level.send_in_direction(Vector2.LEFT, self)
			do_turn()
		elif Input.is_action_just_pressed("ui_down"):
			flag.add_history()
			add_history()
			level.send_in_direction(Vector2.DOWN, flag)
			level.send_in_direction(Vector2.DOWN, self)
			do_turn()
