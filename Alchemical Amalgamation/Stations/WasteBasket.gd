extends Node2D

signal destroy_resource
		
func destroy_resource(): 
	emit_signal("destroy_resource")


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		destroy_resource()
