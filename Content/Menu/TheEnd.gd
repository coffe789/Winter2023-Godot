extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fadeout")
	var r = get_tree().get_root().get_node_or_null("WorldRoot/RestartButton")
	if r: r.queue_free()
