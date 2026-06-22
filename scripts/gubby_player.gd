extends Node

signal game_win
signal game_lost
signal got_key

const KEY = preload("res://scenes/key.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("carrot"):
		area.get_parent().queue_free()
		game_win.emit()
		MusicManager.play_sound("res://assets/audio/eat.wav")
	elif area.get_parent().is_in_group("death"):
		game_lost.emit()
		MusicManager.play_sound("res://assets/audio/boom2.wav")

# To be called after each move.
func check_and_grab_key():
	var has_tag = GameInfo.check_tiles_with_tag(self.global_position, "key")
	if has_tag:
		print("KEY GOT")
		# Grab Key
		# Add floating key around player and play sfx
		# Instantiate a prefab, probably
		var key = KEY.instantiate()
		add_child(key)
		MusicManager.play_sound("res://assets/audio/healSound.wav")
		got_key.emit()
