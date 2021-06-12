extends Node2D

signal drop_resource
signal pick_up_resource(resource_type)

onready var global_vars = get_node("/root/GlobalVariables")

var resource = null

func _on_Area2D_input_event(viewport, event, shape_idx):
	if resource == null and event is InputEventMouseButton and event.is_pressed():
		emit_signal("drop_resource")
		var water = global_vars.get_resource(global_vars.Resources.WATER)
		print("global var resource water: " + str(water))
		resource = water
		resource.slot = self
		add_child(water)
		
func pick_up(): 
	if resource != null: 
		print("non null resource")
		emit_signal("pick_up_resource", resource.resource_type)
		resource.queue_free()

