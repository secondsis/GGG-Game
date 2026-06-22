extends CharacterBody2D

signal after_player_move

@onready var AnimatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var up_raycast : RayCast2D = $up
@onready var down_raycast : RayCast2D = $down
@onready var right_raycast : RayCast2D = $right
@onready var left_raycast : RayCast2D = $left

@export var movement_sfx : AudioStream

var is_my_turn : bool = false
var facing_direction : String = "right"
var anim_tween : Tween

func face_direction(dir: String):
	facing_direction = dir
	if dir == "right":
		AnimatedSprite.flip_h = true
	else:
		AnimatedSprite.flip_h = false

func has_input_bool(action_released: String):
	var action_keycodes = ["ui_up", "ui_down", "ui_left", "ui_right"]
	action_keycodes.erase(action_released)
	var others_pressing : bool = false
	for action in action_keycodes:
		if Input.is_action_pressed(action):
			others_pressing = true
			break
	
	return Input.is_action_just_released(action_released) and !others_pressing

func _move(dir: Vector2):
	# Move the overall player forward
	self.global_position += dir * GameInfo.TILE_SIZE
	# Keep the sprite behind for a bit until the tween
	AnimatedSprite.global_position -= dir * GameInfo.TILE_SIZE
	
	if anim_tween:
		anim_tween.kill()
	anim_tween = self.create_tween()
	anim_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	anim_tween.tween_property(AnimatedSprite, "global_position", self.global_position, 0.2)
	anim_tween.set_trans(Tween.TRANS_SINE)
	
	if movement_sfx:
		MusicManager.play_sound_stream(movement_sfx)

# process animations
func _process(delta: float) -> void:
	if !is_my_turn:
		return
	if !anim_tween or !anim_tween.is_running():
		if Input.is_action_just_pressed("ui_up"):
			face_direction("up")
		elif Input.is_action_just_pressed("ui_down"):
			face_direction("down")
		elif Input.is_action_just_pressed("ui_right"):
			face_direction("right")
		elif Input.is_action_just_pressed("ui_left"):
			face_direction("left")
	if anim_tween and anim_tween.is_running():
		if has_input_bool("ui_up"):
			AnimatedSprite.play("walk_up")
			face_direction("up")
			
		elif has_input_bool("ui_down"):
			AnimatedSprite.play("walk_down")
			face_direction("down")
		
		if has_input_bool("ui_right"):
			AnimatedSprite.play("walk_left")
			face_direction("right")
		elif has_input_bool("ui_left"):
			AnimatedSprite.play("walk_left")
			face_direction("left")
	
	if (anim_tween != null && !anim_tween.is_running()):
		var idle_direction = facing_direction
		if idle_direction == "right":
			idle_direction = "left"
		AnimatedSprite.play("idle_" + idle_direction)

func _physics_process(delta: float) -> void:
	if !is_my_turn:
		return
	
	if !anim_tween or !anim_tween.is_running():
		if has_input_bool("ui_up"):
			if !up_raycast.is_colliding():
				_move(Vector2.UP)
			after_player_move.emit()
		elif has_input_bool("ui_down"):
			if !down_raycast.is_colliding():
				_move(Vector2.DOWN)
			after_player_move.emit()
		elif has_input_bool("ui_right"):
			if !right_raycast.is_colliding():
				_move(Vector2.RIGHT)
			after_player_move.emit()
		elif has_input_bool("ui_left"):
			if !left_raycast.is_colliding():
				_move(Vector2.LEFT)
			after_player_move.emit()
	
	

func _on_switch_turns(is_turn: bool) -> void:
	is_my_turn = is_turn

func _on_game_win():
	# Stop movement
	is_my_turn = false
