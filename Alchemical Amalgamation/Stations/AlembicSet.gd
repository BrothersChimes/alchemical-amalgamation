extends Node2D

signal alembic_click()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("alembic_click")

func add_ingredient_to_alembic(): 
	$Empty.visible = false
	$InUse.visible = true
	$Output.visible = false
	
func finish_alembic(): 
	$Empty.visible = false
	$InUse.visible = true
	$Output.visible = true
	
func take_ingredient_from_alembic(): 
	$Empty.visible = true
	$InUse.visible = false
	$Output.visible = false
