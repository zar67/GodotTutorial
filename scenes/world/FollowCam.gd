extends Camera2D

@export var tilemap: TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSizeInPixels = mapRect.size * tileSize
	
	limit_left = mapRect.position.x * tileSize
	limit_top = mapRect.position.y * tileSize
	limit_right = limit_left + worldSizeInPixels.x
	limit_bottom = limit_top + worldSizeInPixels.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
