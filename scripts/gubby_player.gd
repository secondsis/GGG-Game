extends Node

signal game_win
signal game_lost

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("carrot"):
		area.get_parent().queue_free()
		game_win.emit()
		MusicManager.play_sound("res://assets/audio/eat.wav")
	elif area.get_parent().is_in_group("death"):
		game_lost.emit()
		MusicManager.play_sound("res://assets/audio/boom2.wav")
