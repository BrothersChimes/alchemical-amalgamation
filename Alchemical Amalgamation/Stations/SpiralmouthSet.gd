extends Node2D

signal spiral_click()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("spiral_click")

func add_ingredient_to_spiral(): 
	$Empty.visible = false
	$InUse.visible = true
	$Output.visible = false
	
func finish_spiral(): 
	$Empty.visible = false
	$InUse.visible = true
	$Output.visible = true
	
func take_ingredient_from_spiral(): 
	$Empty.visible = true
	$InUse.visible = false
	$Output.visible = false
