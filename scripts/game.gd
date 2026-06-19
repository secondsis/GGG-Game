extends Node

signal void_player_turn
signal gubby_player_turn
signal game_win
signal game_lost
signal tile_eat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	void_player_turn.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
