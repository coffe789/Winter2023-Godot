extends Sprite
class_name DialogueBox

var t
var dialogue
var dcontainer = preload("res://Content/UI/DialogueContainer.tscn")
var text_complete
var lifetime

func _init(text : String, _offset = Vector2(0, -4), _scale := 0.3, life_time = 0.5) -> void:
	var d = dcontainer.instance(); d.rect_position = Vector2(0,-9); add_child(d)
	t = Timer.new(); t.connect("timeout", self, "append_new_letter")
	t.wait_time = 0.05; add_child(t); t.one_shot = true
	dialogue = text
	
	scale = Vector2(_scale,_scale)
	position = _offset
	z_index = 100
	lifetime = life_time

func _ready():
	t.start()
	add_to_group("dialoguebox")
	for x in get_tree().get_nodes_in_group("dialoguebox"):
		if not x == self: x.queue_free()

func append_new_letter() -> void:
	var label = $A/CentreContainer/Label
	if label.text.length() < dialogue.length():
		label.text += dialogue[label.text.length()]
		if label.text.length() < dialogue.length():
			var next_char = dialogue[label.text.length()]
			if (next_char == '.' or next_char == '?' or next_char == '!' or next_char == ','):
				t.start(t.wait_time*2)
				return
		t.start()
	else:
		text_complete = true
		var tt = Timer.new(); tt.wait_time = lifetime; add_child(tt)
		tt.connect("timeout", self, "queue_free"); tt.start()


func _input(event:InputEvent):
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.is_pressed()):
		if text_complete:
			queue_free()
		else:
			t.wait_time /= 2
