extends Node2D

signal click_on_combinator_slot(slot_num)


func click_on_combinator_slot(slot_num):
	print("COMBINATOR COMBINATOR SLOT " + str(slot_num) + " CLICKED")
	emit_signal("click_on_combinator_slot", slot_num)

func set_slot_to_item(slot_num, resource_type): 
	match slot_num: 
		0: $CombinatorSlot0.set_item_to(resource_type)
		1: $CombinatorSlot1.set_item_to(resource_type)
		2: $CombinatorSlot2.set_item_to(resource_type)
