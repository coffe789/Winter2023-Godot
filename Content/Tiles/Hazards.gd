extends TileMap

var ice    #= preload("")
var water  = preload("res://Content/Water/Water.tscn")
var spikes = preload("res://Content/Spike/Spike.tscn")
var wall   = preload("res://Content/Barrier/Barrier.tscn")
var red_barrier = preload("res://Content/Switch/RedBarrier.tscn")
var blue_barrier = preload("res://Content/Switch/BlueBarrier.tscn")
var red_switch = preload("res://Content/Switch/SwitchRed.tscn")
var blue_switch = preload("res://Content/Switch/SwitchBlue.tscn")

func _ready():
	for p in get_used_cells():
		match get_cellv(p):
			0: # ice
				spawn_at_tile(ice,    p)
			1: # water
				spawn_at_tile(water,  p)
			2: # spikes
				spawn_at_tile(spikes, p)
			3: # wall
				spawn_at_tile(wall,   p)
			4: # red barrier
				spawn_at_tile(red_barrier, p)
			5: # blue barrier
				spawn_at_tile(blue_barrier, p)
			6:
				spawn_at_tile(red_switch, p)
			7:
				spawn_at_tile(blue_switch, p)
			# etcetera

func spawn_at_tile(object, tilepos):
	if object:
		var o = object.instance(); o.position = tilepos * cell_size
		add_child(o)
