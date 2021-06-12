extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	var pos = get_viewport().get_mouse_position()
	position = pos

func destroy(): 
	queue_free()
