extends Sprite
class_name DialogueBox

var t
var dialogue
var dcontainer = preload("res://Content/UI/DialogueContainer.tscn")
var text_complete

func _init(text : String, offset = Vector2(0,0), _scale := 0.3) -> void:
	var d = dcontainer.instance(); d.rect_position = Vector2(-20,-17); add_child(d)
	t = Timer.new(); t.connect("timeout", self, "append_new_letter")
	t.wait_time = 0.05; add_child(t); t.one_shot = true
	dialogue = text
	
	scale = Vector2(_scale,_scale)
	position = offset
	z_index = 10

func _ready():
	t.start()

func append_new_letter() -> void:
	if $VBoxContainer/Label.text.length() < dialogue.length():
		$VBoxContainer/Label.text += dialogue[$VBoxContainer/Label.text.length()]
		if $VBoxContainer/Label.text.length() < dialogue.length():
			var next_char = dialogue[$VBoxContainer/Label.text.length()]
			if (next_char == '.' or next_char == '?' or next_char == '!' or next_char == ','):
				t.start(t.wait_time*2)
				return
		t.start()
	else:
		text_complete = true


func _input(event:InputEvent):
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.is_pressed()):
		if text_complete:
			queue_free()
		else:
			t.wait_time /= 2
