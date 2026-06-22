extends Camera2D

var default_world_width : int = 20 * GameInfo.TILE_SIZE
var default_world_height : int = 10 * GameInfo.TILE_SIZE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_camera_zoom(default_world_width, default_world_height)

func set_camera_zoom(world_width: int, world_height: int):
	var viewport_size : Vector2 = get_viewport_rect().size
	#print(viewport_size)
	#print(str(world_width) + ", " + str(world_height))
	# Pick whichever side is smallest
	self.position = Vector2(world_width / 2, world_height / 2)
	var zoom_size_x : int = viewport_size.x / world_width
	var zoom_size_y : int = viewport_size.y / world_height
	var zoom_size : int = min(zoom_size_x, zoom_size_y)
	self.zoom = Vector2(
	zoom_size,
	zoom_size
	)
