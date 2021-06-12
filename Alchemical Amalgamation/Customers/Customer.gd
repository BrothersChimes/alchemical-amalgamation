extends Node2D

signal sell_potion_to(This)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("sell_potion_to", self)

func sell_potion(potion): 
	queue_free()
