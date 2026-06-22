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
	MusicManager.play_music(GameInfo.get_level_info()["music"])
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("redo_level"):
		redo()

func redo():
	get_tree().change_scene_to_packed(GameInfo.get_level_info()["scene"])

func _on_continue() -> void:
	print("CONTINUE")
	next_level = GameInfo.level_info[GameInfo.current_level]["scene"]
	MusicManager.play_sound("res://assets/audio/mouseClick.wav")

# Go to next level
func _on_transition_finished():
	if next_level != null:
		GameInfo.increase_level()
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
	MusicManager.play_sound("res://assets/audio/win.wav")
	# MAKE SURE TO CONNECT GAME WIN TO EACH PLAYER
	

func _on_game_lost() -> void:
	print("game lost!")


func _on_void_script_tile_eaten() -> void:
	amount_eat_left -= 1
	check_eaten_all()
