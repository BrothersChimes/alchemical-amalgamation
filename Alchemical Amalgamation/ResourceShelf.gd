extends Node2D

#onready var global_vars = get_node("/root/GlobalVariables")
const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
const ResourceType = ResourceTypeFile.ResourceType

export (ResourceTypeFile.ResourceType) var resource_type = ResourceType.WATER
export (String) var display_name = "Water"

func _ready(): 
	$RichTextLabel.text = display_name
	$Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource_type))

signal drag_resource(resource_type)

func _on_ResourceArea_input_event(_viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("drag_resource", resource_type)

func _on_ResourceArea_area_entered(area):
	if area.name == "HoverHackArea":
		$RichTextLabel.visible = true

func _on_ResourceArea_area_exited(area):
	if area.name == "HoverHackArea":
		$RichTextLabel.visible = false

