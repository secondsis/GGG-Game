extends Node

signal void_player_turn(is_turn: bool)
signal gubby_player_turn(is_turn: bool)
signal game_win
signal game_lost

var amount_eat_left : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	void_player_turn.emit(true)
	gubby_player_turn.emit(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_eaten_all():
	if amount_eat_left <= 0:
		# IF all of the items have been eaten, kill void
		void_player_turn.emit(false)
		gubby_player_turn.emit(true)
		get_node("/root/Main/VoidPlayer").queue_free()

func _on_game_win() -> void:
	print("game won!")


func _on_game_lost() -> void:
	print("game lost!")


func _on_void_script_tile_eaten() -> void:
	amount_eat_left -= 1
	check_eaten_all()
