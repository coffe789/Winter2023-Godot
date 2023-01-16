extends Node

signal move_everything
signal go_back

var disable_walk = false # Player input
var disable_undo = false # Player input
var dialogue_progress = 0

# Returns null if there's no level
func get_level() -> Level:
	return get_tree().get_nodes_in_group("level").pop_back()

func get_flag() -> Flag:
	var flag =  get_tree().get_nodes_in_group("flag").pop_back()
	if not flag: return get_tree().get_nodes_in_group("dead_flag").pop_back()
	else: return flag

func get_dragons():
	if get_tree().get_nodes_in_group("dragon"): return get_tree().get_nodes_in_group("dragon")
	else: return null

func _process(_delta) -> void:
	if Input.is_action_just_pressed("undo") and not disable_undo:
		emit_signal("go_back")
		$undo.pitch_scale = rand_range(0.9,1.1)
		$undo.play()
	if Input.is_action_just_pressed("restart") and not disable_walk:
		if get_level() and get_level().name != "TitleScreen" and get_level().name != "TheEnd":
			get_level().get_parent().restart_level(null)

func epic_spaghetti_code(gobackbutton) -> void:
	emit_signal("go_back"); if gobackbutton: gobackbutton.queue_free()
	$undo.pitch_scale = rand_range(0.9,1.1)
	$undo.play()

func play_music(): $music.play()
