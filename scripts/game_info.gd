extends Node

const TILE_SIZE = 16
const GAME_VERSION = "0.0.0"

var current_level = 1
#var stars_collected = 0

const level_info = [
	{ # Level 1
		"scene": preload("res://scenes/level_1.tscn"),
		"void_turns": 1,
		"scene_size": Vector2(20, 10),
		"music": "res://assets/audio/8_bit_game.mp3"
	},
	{ # Level 2
		"scene": preload("res://scenes/level_2.tscn"),
		"void_turns": 3,
		"scene_size": Vector2(20, 10),
		"music": "res://assets/audio/8_bit_game.mp3"
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
