extends Node

signal game_start
signal void_player_turn(is_turn: bool)
signal gubby_player_turn(is_turn: bool)
signal game_lost

var amount_eat_left : int = 1
var next_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	void_player_turn.emit(true)
	gubby_player_turn.emit(false)
	game_start.emit()
	#var continue_button : Button = %ContinueButton
	#continue_button.button_up.connect(_on_continue)

func _on_continue() -> void:
	print("CONTINUE")
	next_level = preload("res://scenes/hello_world.tscn")
	

func _on_transition_finished():
	if next_level != null:
		get_tree().change_scene_to_packed(next_level)


func check_eaten_all():
	if amount_eat_left <= 0:
		# IF all of the items have been eaten, kill void
		void_player_turn.emit(false)
		get_node("/root/Main/VoidPlayer").queue_free()
		await get_tree().process_frame
		gubby_player_turn.emit(true)
		

func _on_game_win() -> void:
	print("game won!")
	# Call a UI to come up
	var win_screen : Control = get_node("/root/Main/CanvasLayer/WinScreen")
	win_screen.visible = true
	# MAKE SURE TO CONNECT GAME WIN TO EACH PLAYER
	

func _on_game_lost() -> void:
	print("game lost!")


func _on_void_script_tile_eaten() -> void:
	amount_eat_left -= 1
	check_eaten_all()
