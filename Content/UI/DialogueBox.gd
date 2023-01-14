extends Sprite
class_name DialogueBox

var t
var dialogue
var dcontainer = preload("res://Content/UI/DialogueContainer.tscn")

func _init(text : String) -> void:
	var d = dcontainer.instance(); d.rect_position = Vector2(-20,-17); add_child(d)
	t = Timer.new(); t.connect("timeout", self, "append_new_letter")
	t.wait_time = 0.05; t.one_shot = true; t.start()
	dialogue = text

func append_new_letter() -> void:
	if Label.text.length() < dialogue.length():
		Label.text.append(dialogue[Label.text.length - 1])
		t.start()
