extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	var s : VideoStreamPlayer = %VideoStreamPlayer
	s.play()
	await s.finished
	get_tree().change_scene_to_file("res://scenes/final.tscn")
