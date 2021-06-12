extends Node2D

# onready var global_vars = get_node("/root/GlobalVariables")

var resource_type

func _process(delta):
	var pos = get_viewport().get_mouse_position()
	position = pos

func destroy(): 
	queue_free()
