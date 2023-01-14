extends Sprite
class_name DialogueBox

var t
var dialogue
var dcontainer = preload("res://Content/UI/DialogueContainer.tscn")
var text_complete

func _init(text : String) -> void:
	var d = dcontainer.instance(); d.rect_position = Vector2(-20,-17); add_child(d)
	t = Timer.new(); t.connect("timeout", self, "append_new_letter")
	t.wait_time = 0.1; add_child(t); t.one_shot = true
	dialogue = text

func _ready():
	t.start()

func append_new_letter() -> void:
	if $VBoxContainer/Label.text.length() < dialogue.length():
		$VBoxContainer/Label.text += dialogue[$VBoxContainer/Label.text.length()]
		t.start()
	else:
		text_complete = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if text_complete:
			queue_free()
		else:
			t.wait_time = 0.01
