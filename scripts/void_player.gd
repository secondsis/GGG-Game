extends Node2D

signal tile_eaten

@onready var tilemap_parent : Node2D = get_node("/root/Main/TileMap")
@onready var tilemap_layers : Array[TileMapLayer] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tilemap_children = tilemap_parent.get_children()
	
	for tilemap in tilemap_children:
		if tilemap is TileMapLayer:
			tilemap_layers.append(tilemap)
	
	tilemap_layers.reverse()

func delete_all_voidable_tiles(pos: Vector2):
	for tilemap_layer in tilemap_layers:
		var is_voidable : bool = check_voidable_tile(pos, tilemap_layer)
		if is_voidable:
			var map_pos = tilemap_layer.local_to_map(pos)
			#var adjacent_tiles = tilemap_layer.get_surrounding_cells(map_pos)
			tilemap_layer.erase_cell(map_pos)
			# i spent so long trying to figure out how to make the tiles connect after deletion
			#tilemap_layer.set_cells_terrain_connect(adjacent_tiles, 0, 0)
# oh ymy hod
			#tilemap_layer.set_cells_terrain_connect([adjacent_tiles.get(2)], 0, 0, true)
			#tilemap_layer.set_cell(map_pos)
			tile_eaten.emit()
			if randi() % 2 == 0:
				MusicManager.play_sound("res://assets/audio/boom1.wav")
			else: 
				MusicManager.play_sound("res://assets/audio/boom2.wav")
			# Only the highest layer can be eaten at a time
			break

func check_voidable_tile(pos: Vector2, tilemap_layer: TileMapLayer) -> bool:
	var this_cell = tilemap_layer.local_to_map(pos)
	var cell_data = tilemap_layer.get_cell_tile_data(this_cell)
	
	if cell_data == null:
		return false
	
	return cell_data.get_custom_data("Voidable") == true


func _on_void_player_after_player_move() -> void:
	delete_all_voidable_tiles(self.global_position)
