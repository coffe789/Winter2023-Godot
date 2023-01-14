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
	pass

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
			if "[eee]" in tile:
				print("kitty in tile")
			for object in tile:
				prints(object,i,j)
