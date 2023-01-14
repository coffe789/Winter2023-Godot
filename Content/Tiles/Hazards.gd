extends TileMap

var ice    #= preload("")
var water  #= preload("")
var spikes #= preload("")
var wall   = preload("res://Content/Barrier/Barrier.tscn")

func _ready():
	for p in get_used_cells():
		match get_cellv(p):
			0: # ice
				spawn_at_tile(ice,    p)
			1: #
				pass
			2: # spikes
				spawn_at_tile(spikes, p)
			3: # wall
				spawn_at_tile(wall,   p)
			4: # water
				spawn_at_tile(water,  p)
			# etcetera

func spawn_at_tile(object, tilepos):
	if object:
		var o = object.instance(); o.position = tilepos * cell_size
		add_child(o)
