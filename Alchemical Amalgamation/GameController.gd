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
		resource_carried = resource_type
		$ResourceDrag.change_resource(resource_type)
		
func _on_Workroom_destroy_resource():
	resource_carried = ResourceType.NONE
	$ResourceDrag.change_resource(ResourceType.NONE)
	
func _on_Workroom_drop_resource():
	resource_carried = ResourceType.NONE
	$ResourceDrag.change_resource(ResourceType.NONE)
	
func _on_CustomerText_sell_potion_to(customer):
	resource_carried = ResourceType.NONE
	$ResourceDrag.change_resource(ResourceType.NONE)
#	var held_resource = $ResourceDrag
#	if held_resource != null:
#		held_resource.destroy()
#		customer.sell_potion(held_resource)
#	resource_carried = ResourceType.NONE
	
func _on_Workroom_pick_up_resource(resource_type):
	if resource_carried == ResourceType.NONE:
		resource_carried = resource_type
		$ResourceDrag.change_resource(resource_type)

