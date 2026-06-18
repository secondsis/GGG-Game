extends CharacterBody2D

@onready var AnimatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@export var SPEED : float = 50
# false = void, true = gubby
@export var PLAYER_TYPE : bool = false
var direction : String = "right"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement_y : float = Input.get_axis("ui_down", "ui_up")
	var movement_x : float = Input.get_axis("ui_left", "ui_right")
	
	if movement_y > 0:
		AnimatedSprite.play("walk_up")
		AnimatedSprite.flip_h = false
		direction = "up"
		
	elif movement_y < 0:
		AnimatedSprite.play("walk_down")
		AnimatedSprite.flip_h = false
		direction = "down"
	
	if movement_x > 0:
		AnimatedSprite.play("walk_left")
		AnimatedSprite.flip_h = true
		direction = "right"
	elif movement_x < 0:
		AnimatedSprite.play("walk_left")
		AnimatedSprite.flip_h = false
		direction = "left"
	
	if movement_x == 0 && movement_y == 0:
		var idle_direction = direction
		if idle_direction == "right":
			idle_direction = "left"
		AnimatedSprite.play("idle_" + idle_direction)
	
	
func _physics_process(delta: float) -> void:
	var movement_y : float = Input.get_axis("ui_down", "ui_up")
	var movement_x : float = Input.get_axis("ui_left", "ui_right")
	
	if movement_y > 0 and !$up.is_colliding():
		self.velocity.y = -SPEED
		
	elif movement_y < 0 and !$down.is_colliding():
		self.velocity.y = SPEED
	else:
		self.velocity.y = 0
	
	if movement_x > 0 and !$right.is_colliding():
		self.velocity.x = SPEED
	elif movement_x < 0 and !$left.is_colliding():
		self.velocity.x = -SPEED
	else:
		self.velocity.x = 0

	self.move_and_slide()

func _move(dir: Vector2):
	self.global_position += dir * 
