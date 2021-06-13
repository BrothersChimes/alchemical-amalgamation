extends Node2D

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

export var customer_number = 0

signal  click_on_customer(number)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("click_on_customer", customer_number)

func set_customer_message_and_item(message,resource_type): 
	print("Setting message")
	$RichTextLabel.text = message
	visible = true
	$ItemPlacement/Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource_type))
	
func remove_customer(): 
	visible = false
