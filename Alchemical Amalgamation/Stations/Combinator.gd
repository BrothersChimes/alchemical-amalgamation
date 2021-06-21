extends Node2D

signal click_on_combinator_slot(slot_num)
signal click_on_combinator_output()
const ResourceTypeFile = preload("res://Resources/ResourceType.gd")

func click_on_combinator_slot(slot_num):
	print("COMBINATOR COMBINATOR SLOT " + str(slot_num) + " CLICKED")
	emit_signal("click_on_combinator_slot", slot_num)

func set_slot_to_item(slot_num, resource_type, output): 
	match slot_num: 
		0: $CombinatorSlot0.set_item_to(resource_type)
		1: $CombinatorSlot1.set_item_to(resource_type)
		2: $CombinatorSlot2.set_item_to(resource_type)
	set_output_to_item(output)

func set_output_to_item(resource_type): 
	if resource_type == ResourceTypeFile.ResourceType.NONE: 
		$CombinatorOutput.visible = false
		return
	print("SETTING OUTPUT TO " + str(resource_type))
	$CombinatorOutput.visible = true
	var resource_path = ResourceTypeFile.sprite_path_for_resource_type(resource_type)
	print("Resource path: " + resource_path)
	$CombinatorOutput/Sprite.texture = load(resource_path)

func _on_CombinatorOutputArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("click_on_combinator_output")
