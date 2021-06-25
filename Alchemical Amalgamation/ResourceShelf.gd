extends Node2D

signal drag_resource(resource_type)

#onready var global_vars = get_node("/root/GlobalVariables")
const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
const ResourceType = ResourceTypeFile.ResourceType

export (ResourceTypeFile.ResourceType) var resource_type = ResourceType.WATER
var price = 0

func _ready(): 
	price = ResourceTypeFile.buy_price_for(resource_type)
	$LabelHolder/Label.text = ResourceTypeFile.display_name(resource_type)
	$LabelHolder/Label.visible = false
	$Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource_type))

func _on_ResourceArea_input_event(_viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("drag_resource", resource_type)

func _on_ResourceArea_area_entered(area):
	if area.name == "HoverHackArea":
		$LabelHolder/Label.text = ResourceTypeFile.display_name(resource_type) + ": " + str(price) + "gp"
		$LabelHolder/Label.visible = true

func _on_ResourceArea_area_exited(area):
	if area.name == "HoverHackArea":
		$LabelHolder/Label.visible = false

