extends Node

const TILE_SIZE = 16
const GAME_VERSION = "0.0.0"

var current_level = 1
var stars_collected = 0

func get_descendants(node: Node):
	var descendants : Array[Node] = []
	
	# my brain hurts
	for child in node.get_children():
		descendants.append(child)
		descendants.append_array(get_descendants(child))
	
	return descendants
