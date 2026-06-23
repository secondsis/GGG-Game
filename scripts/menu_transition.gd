extends Node

var played = false

func transition():
	if played:
		return
	played = true
	get_node("/root/Menu/AudioStreamPlayer").stop()
	MusicManager.play_sound("res://assets/audio/mouseClick.wav")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 3)
	self.get_parent().find_child("AnimationController").find_child("AnimatedSprite2D").play("walk")
	await tween.finished
	
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
