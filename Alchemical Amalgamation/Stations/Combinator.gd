extends Node2D

signal dropped_resource()
signal pick_up_resource(resource_type)

func _on_CombinatorSlot1_drop_resource():
	emit_signal("dropped_resource")

func _on_CombinatorSlot2_drop_resource():
	emit_signal("dropped_resource")

func _on_CombinatorSlot3_drop_resource():
	emit_signal("dropped_resource")

func _on_CombinatorSlot_pick_up_resource(resource_type):
	print("COMBINATOR PICK UP RESOURCE")
	emit_signal("pick_up_resource", resource_type)
