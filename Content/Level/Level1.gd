extends Node2D
class_name Level

export(Vector2) var grid_size = Vector2(15,15)
var grid : Array

const TILE_SIZE = 8

func init_object(object):
	if int(object.position.x) % TILE_SIZE != 0 or int(object.position.y) % TILE_SIZE != 0:
		push_error(object.name + " is not aligned to the grid")
	else:
		grid[object.position.x/TILE_SIZE][object.position.y/TILE_SIZE].append(object)

func get_grid_pos(object) -> Vector2:
	return Vector2(object.position.x/TILE_SIZE, object.position.y/TILE_SIZE)

func is_pos_valid(pos : Vector2) -> bool:
	return pos.x >= 0 and pos.x < grid_size.x and pos.y >= 0 and pos.y < grid_size.y

func send_to_tile(tile_pos, object):
	var pos = get_grid_pos(object)
	if is_pos_valid(tile_pos):
		grid[pos.x][pos.y].erase(object)
		grid[tile_pos.x][tile_pos.y].append(object)
		object.position = tile_pos * TILE_SIZE

func send_in_direction(direction, object):
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
			i.append([])

func _init():
	init_grid()

func _ready():
	resolve_collisions()

func resolve_collisions():
	for i in grid_size.x:
		for j in grid_size.y:
			var tile = grid[i][j]
			
			var is_kitty = false
			var is_barrier = false
			var is_flag = false
			
			for object in tile:
				if object.is_in_group("barrier"): is_barrier = true
				if object.is_in_group("kitty"): is_kitty = true
				if object.is_in_group("flag"): is_flag = true
			
			if is_barrier:
				for object in tile:
					object.undo_history()
			
			if is_flag and is_kitty:
				print("win")
