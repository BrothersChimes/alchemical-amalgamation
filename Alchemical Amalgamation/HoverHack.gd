extends Node2D


func _process(delta):
	var pos = get_viewport().get_mouse_position()
	position = pos


func _on_HoverHackArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		print("CLICKED ON HOVER HACK")
