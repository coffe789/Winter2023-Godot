extends Node2D
class_name Level

export(Vector2) var grid_size = Vector2(15,15)
var grid : Array
onready var LevelManager = get_parent()

const TILE_SIZE = 8

var is_state_red = true
func set_is_red_state(is_red):
	if is_state_red == is_red:
		return
	is_state_red = is_red
	for i in grid_size.x:
		for j in grid_size.y:
			var tile = grid[i][j]
			if tile.has_group("red_switch"):
				tile.get_first_in_group("red_switch").change_state()
			if tile.has_group("blue_switch"):
				tile.get_first_in_group("blue_switch").change_state()
			if tile.has_group("red_barrier"):
				tile.get_first_in_group("red_barrier").change_state()
			if tile.has_group("blue_barrier"):
				tile.get_first_in_group("blue_barrier").change_state()


class Tile:
	var obj := []

	func append(_obj):
		obj.append(_obj)
	func erase(_obj):
		obj.erase(_obj)
	func size():
		return obj.size()
	
	func has_group(group : String) -> bool:
		for o in obj:
			if o.is_in_group(group):
				return true
		return false
	func get_first_in_group(group : String) -> Node:
		for o in obj:
			if o.is_in_group(group):
				return o
		push_error("requested group: " + group + " from a tile when it doesn't exist")
		return null
	
func init_object(object):
	if int(object.position.x) % TILE_SIZE != 0 or int(object.position.y) % TILE_SIZE != 0:
		push_error(object.name + " is not aligned to the grid")
	else:
		grid[object.position.x/TILE_SIZE][object.position.y/TILE_SIZE].append(object)

func get_grid_pos(object) -> Vector2:
	return Vector2(object.position.x/TILE_SIZE, object.position.y/TILE_SIZE)

func is_pos_valid(pos : Vector2) -> bool:
	var in_bounds = pos.x >= 0 and pos.x < grid_size.x and pos.y >= 0 and pos.y < grid_size.y
	var in_wall = grid[pos.x][pos.y].has_group("barrier")
	var in_dragon = grid[pos.x][pos.y].has_group("dragon")
	return in_bounds and not in_wall and not in_dragon

func send_to_tile(tile_pos, object):
	var pos = get_grid_pos(object)
	if is_pos_valid(tile_pos):
		grid[pos.x][pos.y].erase(object)
		grid[tile_pos.x][tile_pos.y].append(object)
		object.position = tile_pos * TILE_SIZE

func send_in_direction(direction, object):
	if object.is_in_group("final_flag"):return
	var pos = get_grid_pos(object)
	if is_pos_valid(pos+direction):
		grid[pos.x][pos.y].erase(object)
		pos += direction
		grid[pos.x][pos.y].append(object)
		object.position = pos * TILE_SIZE

func init_grid():
	grid = []
	for i in grid_size.x:
		grid.append([])
	for i in grid:
		for j in grid_size.y:
			i.append(Tile.new())

func _init():
	init_grid()

func _ready():
	resolve_collisions()

var the_end = preload("res://Content/Menu/TheEnd.tscn")
func resolve_collisions():
	for i in grid_size.x:
		for j in grid_size.y:
			var tile = grid[i][j]
			if tile.has_group("final_flag") and tile.has_group("kitty"):
				var te = the_end.instance()
				get_parent().add_child(te)
				queue_free(); return
			if tile.has_group("spike") and (tile.has_group("kitty") or tile.has_group("flag")):
				for obj in tile.obj:
					if obj.is_in_group("kitty") or obj.is_in_group("flag"):
						obj.die("spike")
			if tile.has_group("water") and (tile.has_group("kitty")):
				for obj in tile.obj:
					if obj.is_in_group("kitty"):
						obj.die("water")
			if (tile.has_group("kitty")) and (tile.has_group("dragon")):
				for obj in tile.obj:
					if obj.is_in_group("kitty"):
						obj.die("dragon")
			if (tile.has_group("flag")) and (tile.has_group("dragon")):
				for obj in tile.obj:
					if obj.is_in_group("flag"):
						obj.die("dragon")
			if tile.has_group("flag") and tile.has_group("kitty"):
				Globals.disable_walk = true
				LevelManager.change_level(LevelManager.current_level_id+1)
			if tile.has_group("red_switch") and \
			(tile.has_group("kitty") or (tile.has_group("flag")) or (tile.has_group("dragon"))):
				set_is_red_state(true)
			if tile.has_group("blue_switch") and \
			(tile.has_group("kitty") or (tile.has_group("flag")) or (tile.has_group("dragon"))):
				set_is_red_state(false)

onready var deathscreen = preload("res://Content/Menu/DeathScreen.tscn")
func death_screen():
	var d = deathscreen.instance()
	get_tree().get_root().add_child(d)
	
	yield(get_tree().create_timer(1.0), "timeout")
	if is_instance_valid(d):
		d.get_node("CanvasLayer").visible = true
		
	

