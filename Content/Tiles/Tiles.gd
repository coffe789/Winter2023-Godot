extends TileMap

export var map_image : Texture

func _ready():
	if map_image:
		var im = map_image.get_data() # converts Texture to Image
		im.lock()
		for u in im.get_width():
			for v in im.get_height():
				var col = im.get_pixel(u, v)
				var value = col.v + 0.01
				# value ranges from 0.0 to 1.0, 14 tiles
				var t = value * 14.0
				set_cell(u, v, t)
