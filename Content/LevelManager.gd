extends Node2D

var levels = [
	# 0th entry is for when there's no current level
	false,
	# level preloads go here
	preload("res://Content/TitleScreen/TitleScreen.tscn"),
	preload("res://Content/Level/Level1.tscn"),
	preload("res://Content/Level/LevelWaterTrap.tscn"),
	
	
]

var levelwinmenu = preload("res://Content/Menu/LevelWin.tscn")

var current_level_id = 0
var current_level : Node

func change_level(level_id : int) -> void:
	if current_level:
		var w = levelwinmenu.instance(); add_child(w)
		yield(w, "cont")
		w.queue_free(); current_level.queue_free()
	var l = levels[level_id].instance(); add_child(l)
	current_level = l
	current_level_id = level_id

func exit_title_screen(level_id : int) -> void:
	var l = levels[level_id].instance(); add_child(l)
	current_level = l
	current_level_id = level_id

func _ready():
	change_level(1)
