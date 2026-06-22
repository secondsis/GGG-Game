extends Node

@export var radius : float = 32.0
@export var speed : float = 3.0

var angle := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Every second, increase angle by [speed]
	angle += speed * delta
	
	# yeah i looked this up,
	# basically sine unit circle
	# cos defines x, sin defines y
	# when math is useful: When I Did Not Ask
	self.position = Vector2(cos(angle), sin(angle)) * radius
