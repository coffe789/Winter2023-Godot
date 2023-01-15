extends TileMap

export var map_image : Texture

func _ready():
	var im = map_image.get_data() # converts Texture to Image
	
