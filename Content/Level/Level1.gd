extends Node2D
class_name Level

export(Vector2) var grid_size = Vector2(15,15)
var grid : Array

const TILE_SIZE = 16

func init_object(object):
	if object.position.x % TILE_SIZE != 0 or object.position.y % TILE_SIZE != 0:
		push_warning(object.name + " is not aligned to the grid")
	else:
		grid[object.position.y][object.position.x].append(object)
	
func send_to_tile(tile_pos, object):
	pass

func send_in_direction(direction, object):
	match(direction):
		Vector2.RIGHT:
			pass
		Vector2.UP:
			pass
		Vector2.LEFT:
			pass
		Vector2.DOWN:
			pass

func init_grid():
	grid = []
	for i in grid_size.x:
		grid.append([])
	for i in grid:
		for j in grid_size.y:
			i.append([])

func _ready():
	init_grid()
