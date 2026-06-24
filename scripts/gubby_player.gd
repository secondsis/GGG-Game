extends Node

signal game_win
signal game_lost
signal got_key
signal unlock_door

const KEY = preload("res://scenes/key.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("carrot"):
		area.get_parent().queue_free()
		game_win.emit()
		MusicManager.play_sound("res://assets/audio/eat.wav")
	elif area.get_parent().is_in_group("death"):
		print("game shoudl be lost?")
		game_lost.emit()
		MusicManager.play_sound("res://assets/audio/boom2.wav")

func check_ghost_and_die():
	var has_tag = GameInfo.check_tiles_with_tag(self.global_position, "Ghost")
	if has_tag:
		game_lost.emit()
		MusicManager.play_sound("res://assets/audio/boom2.wav")
# To be called after each move.
func check_and_grab_key():
	var has_tag = GameInfo.check_tiles_with_tag(self.global_position, "Key")
	if has_tag:
		GameInfo.delete_tiles_with_tag(self.global_position, "Key")
		# Grab Key
		# Add floating key around player and play sfx
		# Instantiate a prefab, probably
		var key = KEY.instantiate()
		self.get_parent().find_child("AnimatedSprite2D").add_child(key)
		MusicManager.play_sound("res://assets/audio/healSound.wav")
		got_key.emit()

func check_and_unlock_door():
	if not %GameScript.num_keys >= 1:
		return
	var has_tag = GameInfo.check_surrounding_tiles_with_tag(self.global_position, "Door", true)
	if has_tag:
		%GameScript.num_keys -= 1
		self.get_parent().find_child("AnimatedSprite2D").get_child(0).queue_free()
		MusicManager.play_sound("res://assets/audio/boom2.wav")
		unlock_door.emit()
