extends Node2D

signal click_on_combinator_slot(slot_num)
export var slot_num = 0
const ResourceTypeFile = preload("res://Resources/ResourceType.gd")

func _ready(): 
	$Sprite.visible = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		print("COMBINATOR SLOT CLICKED")
		emit_signal("click_on_combinator_slot", slot_num)

func set_item_to(resource_type):
	if resource_type == ResourceTypeFile.ResourceType.NONE: 
		$Sprite.visible = false
		return
	$Sprite.visible = true
	$Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource_type))
