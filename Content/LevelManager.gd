extends Node2D

var levels = [
	# 0th entry is for when there's no current level
	false,
	# level preloads go here
	preload("res://Content/TitleScreen/TitleScreen.tscn"),
	preload("res://Content/Level/Level1.tscn"),
	preload("res://Content/Level/LevelWaterIntro.tscn"),
	preload("res://Content/Level/LevelWaterIntro2.tscn"),
	preload("res://Content/Level/LevelVeryNearby.tscn"),
	preload("res://Content/Level/LevelWaterTrapBoogaloo.tscn"),
	preload("res://Content/Level/LevelNearby.tscn"),
]

var levelwinmenu = preload("res://Content/Menu/LevelWin.tscn")

var current_level_id = 0
var current_level : Node

func change_level(level_id : int) -> void:
	if current_level:
		$win.play()
		var w = levelwinmenu.instance(); get_parent().add_child(w)
		yield(w, "cont")
		w.queue_free(); current_level.queue_free()
	var l = levels[level_id].instance(); add_child(l)
	current_level = l
	current_level_id = level_id

func restart_level(restartbutton) -> void:
	if current_level:
		if restartbutton: restartbutton.queue_free()
		current_level.queue_free()
		var l = levels[current_level_id].instance(); add_child(l)
		current_level = l
	$retry.play()

func exit_title_screen(level_id : int) -> void:
	if current_level:
		current_level.queue_free()
	var l = levels[level_id].instance(); add_child(l)
	current_level = l
	current_level_id = level_id

func _ready():
	change_level(1)
#	for i in 48:
#		for j in 48:
#			var a = $AnimatedSprite.duplicate()
#			add_child(a); a.position += 8 * Vector2(i, j)
#			a.speed_scale = 2.0 * rand_range(0.9,1.1)
