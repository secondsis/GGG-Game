extends Node

@export var label : RichTextLabel
var bbcode_start : String = "[shake]"
@export var message : String = "The Void Must Consume"
@onready var camera = get_node("/root/Main/Camera2D")

var debounce = 0.1
var timer = debounce

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(10).timeout
	MusicManager.stop_music()
	get_tree().change_scene_to_file("res://scenes/ending.tscn")

func get_random_case(msg: String):
	var result = ""
	
	for c in msg:
		if randi() % 2 == 0:
			result += c.to_upper()
		else:
			result += c.to_lower()
	return result

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timer = debounce
		if randf() > 0.9:
			camera.toggle_camera_shake(true, true, 8.0, 0.05)
		print(bbcode_start + get_random_case(message))
		label.text = bbcode_start + get_random_case(message)
