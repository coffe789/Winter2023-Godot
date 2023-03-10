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
	preload("res://Content/Level/LevelSwitchIntro.tscn"),
	preload("res://Content/Level/LevelSwitchIntro2.tscn"),
	preload("res://Content/Level/LevelSwitchyBoogo.tscn"),
	preload("res://Content/Level/LevelSwitchySwitchy.tscn"),
	preload("res://Content/Level/DragonIntro.tscn"),
	preload("res://Content/Level/LevelCorridor.tscn"),
	preload("res://Content/Level/LevelController.tscn"),
	preload("res://Content/Level/LevelWindscreen.tscn"),
	preload("res://Content/Level/LevelFinal.tscn"),
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
