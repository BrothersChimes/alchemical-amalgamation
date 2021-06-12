extends Node2D

signal drag_resource_from_shelf(resource_type)
signal destroy_resource
signal click_on_combinator_slot(slot_num)


func _ready():
	pass # Replace with function body.

func _on_WasteBasket_destroy_resource():
	emit_signal("destroy_resource")

func _on_ShelfForIngredients_drag_resource(resource_type):
	emit_signal("drag_resource_from_shelf", resource_type)

func _on_Combinator_click_on_combinator_slot(slot_num):
	print("WORKROOM COMBINATOR SLOT " + str(slot_num) + " CLICKED")
	emit_signal("click_on_combinator_slot", slot_num)

func set_combinator_slot_to_item(slot_num, resource_type): 
	$Combinator.set_slot_to_item(slot_num, resource_type)
