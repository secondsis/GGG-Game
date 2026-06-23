extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var c = self.get_children()
	for sprite in c:
		if sprite is AnimatedSprite2D:
			sprite.play()
