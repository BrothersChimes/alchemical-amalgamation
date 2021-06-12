extends Node2D

signal sell_potion

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		sell_potion()

func sell_potion(): 
	emit_signal("sell_potion")
