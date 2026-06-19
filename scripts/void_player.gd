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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func delete_all_voidable_tiles(pos: Vector2):
	for tilemap_layer in tilemap_layers:
		var is_voidable : bool = check_voidable_tile(pos, tilemap_layer)
		if is_voidable:
			print("ERASE CELL")
			tilemap_layer.erase_cell(tilemap_layer.local_to_map(pos))
			tile_eaten.emit()
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
