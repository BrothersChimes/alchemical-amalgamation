extends Node2D

#onready var global_vars = get_node("/root/GlobalVariables")
const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
const ResourceType = ResourceTypeFile.ResourceType

export (ResourceTypeFile.ResourceType) var resource_type = ResourceType.WATER

func _ready(): 
	$Label.text = ResourceTypeFile.display_name(resource_type)
	$Label.visible = false
	$Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource_type))

signal drag_resource(resource_type)

func _on_ResourceArea_input_event(_viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("drag_resource", resource_type)

func _on_ResourceArea_area_entered(area):
	if area.name == "HoverHackArea":
		$Label.text = ResourceTypeFile.display_name(resource_type)
		$Label.visible = true

func _on_ResourceArea_area_exited(area):
	if area.name == "HoverHackArea":
		$Label.visible = false

