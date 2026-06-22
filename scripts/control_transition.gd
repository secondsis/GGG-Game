extends Node

signal finished_transition

@onready var color_rect = $CenterTransition/ColorRect
@onready var black_panel = $BlackPanel

#var duration = 5
#var timer = duration
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#var test = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#timer -= delta
	#if timer <= 0:
		#if test:
			#exit_transition()
			#test = false
		#else:
			#enter_transition()
			#test = true
		#timer = duration

func exit_transition():
	var descendants : Array[Node] = GameInfo.get_descendants(self)
	for desc in descendants:
		if desc is Control:
			desc.mouse_filter = Control.MOUSE_FILTER_STOP
	self.mouse_filter = Control.MOUSE_FILTER_STOP
	color_rect.material.set_shader_parameter("radius", 1.0)
	color_rect.visible = true
	var tween = create_tween()
	tween.tween_property(color_rect.material, "shader_parameter/radius", 0.0, 0.6)
	await tween.finished
	black_panel.visible = true
	color_rect.visible = false
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for desc in descendants:
		if desc is Control:
			desc.mouse_filter = Control.MOUSE_FILTER_IGNORE
	finished_transition.emit()

func enter_transition():
	await get_tree().process_frame
	var descendants : Array[Node] = GameInfo.get_descendants(self)
	for desc in descendants:
		if desc is Control:
			desc.mouse_filter = Control.MOUSE_FILTER_STOP
	self.mouse_filter = Control.MOUSE_FILTER_STOP
	black_panel.visible = true
	color_rect.material.set_shader_parameter("radius", 0.0)
	color_rect.visible = true
	black_panel.visible = false
	var tween = create_tween()
	tween.tween_property(color_rect.material, "shader_parameter/radius", 1.5, 0.6)
	await tween.finished
	color_rect.visible = false
	for desc in descendants:
		if desc is Control:
			desc.mouse_filter = Control.MOUSE_FILTER_IGNORE

	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	finished_transition.emit()
