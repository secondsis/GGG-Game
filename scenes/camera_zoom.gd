extends Camera2D

const TILE_SIZE = 16

var default_world_width = 20 * TILE_SIZE
var default_world_height = 20 * TILE_SIZE

var viewport_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.zoom = Vector2(
	default_world_width / viewport_size.x,
	default_world_height / viewport_size.y
)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
