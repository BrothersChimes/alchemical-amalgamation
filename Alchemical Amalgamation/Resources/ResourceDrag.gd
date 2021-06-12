extends Node2D

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

func _ready(): 
	visible = false

func _process(_delta):
	var pos = get_viewport().get_mouse_position()
	position = pos

func change_resource(resource_type): 
	if resource_type == ResourceType.NONE: 
		visible = false
		return
	visible = true
	$Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource_type))
