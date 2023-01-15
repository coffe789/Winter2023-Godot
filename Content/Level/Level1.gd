extends Node2D
class_name Level

export(Vector2) var grid_size = Vector2(15,15)
var grid : Array
onready var LevelManager = get_parent()

const TILE_SIZE = 8

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
	else: print(pos, object.name)

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

func resolve_collisions():
	for i in grid_size.x:
		for j in grid_size.y:
			var tile = grid[i][j]
			
			if tile.has_group("barrier"):
				for obj in range(tile.size() -1, -1, -1):
					if tile.has_group("kitty"):
						print(tile.obj[obj])
					tile.obj[obj].undo_history_without_deletion()
			
			if tile.has_group("spike") and (tile.has_group("kitty") or tile.has_group("flag")):
				for obj in tile.obj:
					if obj.is_in_group("kitty") or obj.is_in_group("flag"):
						obj.die()
			if tile.has_group("flag") and tile.has_group("kitty"):
				LevelManager.change_level(LevelManager.current_level_id+1)

