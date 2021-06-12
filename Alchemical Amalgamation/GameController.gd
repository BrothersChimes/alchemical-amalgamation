extends Node2D

onready var global_vars = get_node("/root/GlobalVariables")

var ResourceDrag = preload("res://Resources/ResourceDrag.tscn") # resource is loaded at compile time

func _ready():
	pass # Replace with function body.

func _on_Workroom_drag_resource():
	if not global_vars.is_carrying_item:
		var res = ResourceDrag.instance()
		global_vars.is_carrying_item = true
		add_child(res)

func _on_Workroom_destroy_resource():
	var held_resource = $ResourceDrag
	if held_resource != null:
		held_resource.destroy()
	global_vars.is_carrying_item = false
		
func _on_Workroom_drop_resource():
	var held_resource = $ResourceDrag
	if held_resource != null:
		held_resource.destroy()
	global_vars.is_carrying_item = false
	
func _on_CustomerText_sell_potion_to(customer):
	var held_resource = $ResourceDrag
	if held_resource != null:
		held_resource.destroy()
		customer.sell_potion(held_resource)

func _on_Workroom_pick_up_resource(resource_type):
	print("PICKED UP RESOURCE")
	if not global_vars.is_carrying_item:
		var res = ResourceDrag.instance()
		global_vars.is_carrying_item = true
		add_child(res)
