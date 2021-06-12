extends Node2D

signal drag_resource_from_shelf(resource_type)
signal destroy_resource
signal drop_resource 
signal pick_up_resource(resource_type)

func _ready():
	pass # Replace with function body.

func _on_WasteBasket_destroy_resource():
	emit_signal("destroy_resource")

func _on_Combinator_dropped_resource():
	emit_signal("drop_resource")

func _on_pick_up_resource(resource_type):
	emit_signal("pick_up_resource", resource_type)

func _on_ShelfForIngredients_drag_resource(resource_type):
	emit_signal("drag_resource_from_shelf", resource_type)