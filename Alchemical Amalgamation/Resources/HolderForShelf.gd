extends Node2D

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
const ResourceType = ResourceTypeFile.ResourceType

export var my_number = 0
var resource_type = ResourceType.NONE

signal drag_resource(resource_type, number)

func _ready():
	$Sprite.visible = false
	$Label.visible = false

func _on_ResourceArea_area_entered(area):
	if area.name == "HoverHackArea":
		if resource_type == ResourceType.NONE:
			$Label.visible = false
			return
		$Label.text = ResourceTypeFile.display_name(resource_type)
		$Label.visible = true

func _on_ResourceArea_area_exited(area):
	if area.name == "HoverHackArea":
		$Label.visible = false

func _on_ResourceArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		print("Event pressed")
		emit_signal("drag_resource", resource_type, my_number)

func is_empty(): 
	return (resource_type == ResourceType.NONE)

func set_resource_to(resource): 
	resource_type = resource
	if resource == ResourceType.NONE: 
		$Sprite.visible = false
	else: 
		$Sprite.visible = true
		$Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource_type))
