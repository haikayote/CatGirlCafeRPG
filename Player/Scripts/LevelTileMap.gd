class_name LevelTileMap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.ChangeTilemapBounds(GetTileMapBounds())
	pass # Replace with function body.

func GetTileMapBounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	bounds.append(Vector2(get_used_rect().position*rendering_quadrant_size)) #top left corner
	bounds.append(Vector2(get_used_rect().end * rendering_quadrant_size)) #bottom right corner
	return bounds
