extends Node2D
onready var LevelManager = get_parent()

func _ready():
	$AnimationPlayer.play("play_logo")


func _on_Start_pressed():
	LevelManager.exit_title_screen(LevelManager.current_level_id+1)


func _on_Credits_pressed():
	$Camera2D.position.x = 1024


func _on_Quit_pressed():
	get_tree().quit()


func _on_CreditsReturn_pressed():
	$Camera2D.position.x = 0.0
