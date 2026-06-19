extends Node

# Tell the player controller this
signal switch_turns(is_turn: bool)

@onready var tilemap_wall : TileMapLayer = get_node("/root/Main/TileMap_Wall")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if check_voidable_tile(self.position):
		# Delete this block
		tilemap_wall.erase_cell(tilemap_wall.local_to_map(self.position))

func check_voidable_tile(pos: Vector2) -> bool:
	var this_cell = tilemap_wall.local_to_map(pos)
	var cell_data = tilemap_wall.get_cell_tile_data(this_cell)
	
	if cell_data == null:
		return false
	
	return cell_data.get_custom_data("Voidable") == true

func _on_game_script_void_player_turn() -> void:
	print("void turn!")
	switch_turns.emit(true)
	
func _on_game_script_gubby_player_turn() -> void:
	switch_turns.emit(false)
