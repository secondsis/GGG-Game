extends Node

const TILE_SIZE = 16
const GAME_VERSION = "0.0.0"

var current_level = 1
#var stars_collected = 0

const level_info = [
	{ # Level 1
		"scene": "res://scenes/level_1.tscn",
		"void_turns": 1,
		"scene_size": Vector2(20, 10),
		"music": "res://assets/audio/8_bit_game.mp3"
	},
	{ # Level 2
		"scene": "res://scenes/level_2.tscn",
		"void_turns": 3,
		"scene_size": Vector2(20, 10),
		"music": "res://assets/audio/8_bit_game.mp3"
	},
	{ # Level 3
		"scene": "res://scenes/level_3.tscn",
		"void_turns": 1,
		"scene_size": Vector2(20, 10),
		"music": "res://assets/audio/8_bit_game.mp3"
	},
	{ # Level 4
		"scene": "res://scenes/level_4.tscn",
		"void_turns": 2,
		"scene_size": Vector2(20, 10),
		"music": "res://assets/audio/8_bit_game.mp3"
	},
	{ # Level 5
		"scene": "res://scenes/level_5.tscn",
		"void_turns": 2,
		"scene_size": Vector2(32, 18),
		"music": "res://assets/audio/future_paths.mp3"
	},
]

func increase_level():
	current_level += 1

func get_level_info():
	return level_info.get(current_level-1)

func get_descendants(node: Node):
	var descendants : Array[Node] = []
	
	# my brain hurts
	for child in node.get_children():
		descendants.append(child)
		descendants.append_array(get_descendants(child))
	
	return descendants

func check_surrounding_tiles_with_tag(pos: Vector2, tag: String, deleteAfter := false) -> bool:
	var tilemap_parent : Node2D = get_node("/root/Main/TileMap")

	var tilemap_children = tilemap_parent.get_children()
	
	
	var surrounding_map_pos = [
		pos + Vector2.UP * GameInfo.TILE_SIZE,
		pos + Vector2.DOWN * GameInfo.TILE_SIZE,
		pos + Vector2.RIGHT * GameInfo.TILE_SIZE,
		pos + Vector2.LEFT * GameInfo.TILE_SIZE
	]
	
	for map_pos in surrounding_map_pos:
		if check_tiles_with_tag(map_pos, tag):
			if deleteAfter:
				delete_tiles_with_tag(map_pos, tag)
			return true
	return false

func check_tiles_with_tag(pos: Vector2, tag: String) -> bool:
	var tilemap_parent : Node2D = get_node("/root/Main/TileMap")

	var tilemap_children = tilemap_parent.get_children()
	var tilemap_layers = []
	
	for tilemap in tilemap_children:
		if tilemap is TileMapLayer:
			tilemap_layers.append(tilemap)
	
	for tilemap_layer in tilemap_layers:
		var map_pos = tilemap_layer.local_to_map(pos)
		var is_tag : bool = check_tile_tag(map_pos, tag, tilemap_layer)
		if is_tag:
			return true
	return false
	
func delete_tiles_with_tag(pos: Vector2, tag: String):
	var tilemap_parent : Node2D = get_node("/root/Main/TileMap")

	var tilemap_children = tilemap_parent.get_children()
	var tilemap_layers = []
	
	for tilemap in tilemap_children:
		if tilemap is TileMapLayer:
			tilemap_layers.append(tilemap)
	
	for tilemap_layer in tilemap_layers:
		var map_pos = tilemap_layer.local_to_map(pos)
		var is_tag : bool = check_tile_tag(map_pos, tag, tilemap_layer)
		if is_tag:
			tilemap_layer.erase_cell(map_pos)

func check_tile_tag(pos: Vector2i, tag: String, tilemap_layer):
	var cell_data = tilemap_layer.get_cell_tile_data(pos)
	
	if cell_data == null:
		return false
	
	return cell_data.get_custom_data(tag) == true
