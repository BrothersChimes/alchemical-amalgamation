extends Node2D



const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

var resource_carried = ResourceType.NONE
var resource_combinator= [ResourceType.NONE, ResourceType.NONE, ResourceType.NONE]

func _ready():
	resource_carried = ResourceType.NONE
	resource_combinator 

func _on_Workroom_drag_resource_from_shelf(resource_type):
	if resource_carried == ResourceType.NONE:
		set_carried_resource_to(resource_type)
		
func _on_Workroom_destroy_resource():
	set_carried_resource_to(ResourceType.NONE)
	
func _on_Workroom_drop_resource():
	set_carried_resource_to(ResourceType.NONE)
	
func _on_CustomerText_sell_potion_to(customer):
	set_carried_resource_to(ResourceType.NONE)
#	var held_resource = $ResourceDrag
#	if held_resource != null:
#		held_resource.destroy()
#		customer.sell_potion(held_resource)
#	resource_carried = ResourceType.NONE
	
func _on_Workroom_pick_up_resource(resource_type):
	if resource_carried == ResourceType.NONE:
		set_carried_resource_to(resource_type)

func _on_Workroom_click_on_combinator_slot(slot_num):
	print("MAIN COMBINATOR SLOT " + str(slot_num) + " CLICKED")
	var combinator_resource_type = resource_combinator[slot_num]
	print("COMBINATOR RESOURCE TYPE: " + str(combinator_resource_type))
	if resource_carried == ResourceType.NONE:
		set_combinator_resource_to(slot_num, ResourceType.NONE)
		set_carried_resource_to(combinator_resource_type)
	elif combinator_resource_type == ResourceType.NONE:
		set_combinator_resource_to(slot_num, resource_carried)
		set_carried_resource_to(ResourceType.NONE)

func set_combinator_resource_to(slot_num, resource_type): 
	resource_combinator[slot_num] = resource_type
	$Workroom.set_combinator_slot_to_item(slot_num, resource_type)
	
func set_carried_resource_to(resource_type): 
	resource_carried = resource_type
	$ResourceDrag.change_resource(resource_type)
