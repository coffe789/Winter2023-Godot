extends Sprite
class_name Kitty

var history = []

func _ready():
	var level = Globals.get_level()
	Globals.disable_walk = false
	level.init_object(self)
	add_to_group("kitty")
	Globals.connect("go_back", self, "undo_history")

func do_turn():
	$step.pitch_scale = rand_range(0.9,1.1)
	$step.play()
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
	
	Globals.get_level().death_screen()
	
	var last_history = history[history.size()-1]
	last_history.add_action(funcref(self, "revive"),[])
	
	$death.play()
	match death_type:
		"water":
			$Splash.emitting = true
			$splash.play()
			var ri = randi()%3; match ri:
				0: say("splish")
				1: say("splosh")
				2: say("splsh")
		"spike":
			$Puff.emitting = true
			var ri = randi()%3; match ri:
				0: say("me-owch!")
				1: say("hisss!")
				2: say("reaorw!!")
		"dragon":
			$Fire.emitting = true
			$fire.play(0.4)
			var ri = randi()%3; match ri:
				0: say("sizzle")
				1: say("IT BURNS!!!")
				2: say("AAAAAAAAA")


func revive():
	var ri = randi()%8; match ri:
		0: say("...")
		1: say("Oops!")
		2: say("Hm..")
		3: say("Huh..")
	
	remove_from_group("dead_kitty")
	add_to_group("kitty")

func say(text : String) -> void:
	var d = DialogueBox.new(text)
	add_child(d)

func _process(_delta):
	var level = Globals.get_level()
	var flag = Globals.get_flag()
	var dragon = Globals.get_dragon()

	if not is_in_group("dead_kitty") and not flag.is_in_group("dead_flag") and not Globals.disable_walk:
		if Input.is_action_just_pressed("ui_right"):
			flag.add_history()
			dragon.add_history()
			add_history()
			level.send_in_direction(Vector2.RIGHT, flag)
			level.send_in_direction(Vector2.LEFT, dragon)
			level.send_in_direction(Vector2.RIGHT, self)
			do_turn()
		elif Input.is_action_just_pressed("ui_up"):
			flag.add_history()
			dragon.add_history()
			add_history()
			level.send_in_direction(Vector2.UP, flag)
			level.send_in_direction(Vector2.DOWN, dragon)
			level.send_in_direction(Vector2.UP, self)
			do_turn()
		elif Input.is_action_just_pressed("ui_left"):
			flag.add_history()
			dragon.add_history()
			add_history()
			level.send_in_direction(Vector2.LEFT, flag)
			level.send_in_direction(Vector2.RIGHT, dragon)
			level.send_in_direction(Vector2.LEFT, self)
			do_turn()
		elif Input.is_action_just_pressed("ui_down"):
			flag.add_history()
			dragon.add_history()
			add_history()
			level.send_in_direction(Vector2.DOWN, flag)
			level.send_in_direction(Vector2.UP, dragon)
			level.send_in_direction(Vector2.DOWN, self)
			do_turn()
