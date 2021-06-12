extends Node2D

var ResourceDrag = preload("res://Resources/ResourceDrag.tscn") # resource is loaded at compile time
var i = 0

func _ready():
	pass # Replace with function body.

func _on_Workroom_drag_resource():
	var res = ResourceDrag.instance()
	add_child(res)

func _on_Workroom_destroy_resource():
	print("DESTROY RESOURCE")
	var held_resource = $ResourceDrag
	if held_resource != null:
		held_resource.destroy()

func _on_CustomerText_sell_potion_to(customer):
	i += 1
	print("SELL POTION " + str(i))
	var held_resource = $ResourceDrag
	if held_resource != null:
		held_resource.destroy()
		customer.sell_potion(held_resource)
		
