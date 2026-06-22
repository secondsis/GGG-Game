extends Camera2D

var default_world_width : int = 20 * GameInfo.TILE_SIZE
var default_world_height : int = 10 * GameInfo.TILE_SIZE

var shake_strength = 0.0
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

func _process(delta: float) -> void:
	shake_camera(shake_strength)

func shake_camera(strength: float):
	if strength > 0.0:
		offset = Vector2(randf_range(-strength, strength), randf_range(-strength, strength))
	else:
		offset = Vector2.ZERO

func toggle_camera_shake(enable := true, strength := 8.0, duration := 0.1):
	if !enable:
		shake_strength = 0.0
		return
	shake_strength = strength
	await get_tree().create_timer(duration).timeout
	shake_strength = 0.0
