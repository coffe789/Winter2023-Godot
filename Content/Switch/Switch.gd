extends Sprite
tool

var blue_sprite = preload("res://Content/Switch/switch_blue.png")
var red_sprite = preload("res://Content/Switch/switch_red.png")

export var is_red = true
var pressed

var time = 0
func _process(_delta):
	if pressed:	frame = 1
	else:				frame = 0

	if Engine.editor_hint:
		time += 1
		if time % 100 == 0:
			if is_red: texture = red_sprite
			else: texture = blue_sprite


func _ready():
	if !Engine.editor_hint:
		var level = Globals.get_level()
		level.init_object(self)
		if is_red:
			add_to_group("red_switch")
		else:
			add_to_group("blue_switch")

func undo_history():
	pass

func undo_history_without_deletion():
	pass
