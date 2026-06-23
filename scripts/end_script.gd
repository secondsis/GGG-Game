extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(10).timeout
	MusicManager.stop_music()
	get_tree().change_scene_to_file("res://scenes/ending.tscn")
