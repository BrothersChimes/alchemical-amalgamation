extends Node2D

onready var global_vars = get_node("/root/GlobalVariables")
var resource_type
var slot

func _on_Area2D_input_event(viewport, event, shape_idx):
	if not global_vars.is_carrying_item and event is InputEventMouseButton and event.is_pressed():
		slot.pick_up()
