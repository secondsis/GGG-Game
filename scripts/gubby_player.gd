extends Node

signal game_win

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("carrot"):
		area.get_parent().queue_free()
		game_win.emit()
