extends Camera2D

var default_world_width : int = 20 * GameInfo.TILE_SIZE
var default_world_height : int = 10 * GameInfo.TILE_SIZE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size : Vector2 = get_viewport_rect().size
	# Pick whichever side is smallest
	
	var zoom_size_x : int = viewport_size.x / default_world_width
	var zoom_size_y : int = viewport_size.y / default_world_height
	var zoom_size : int = min(zoom_size_x, zoom_size_y)
	self.zoom = Vector2(
	zoom_size,
	zoom_size
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
