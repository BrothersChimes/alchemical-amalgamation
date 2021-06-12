extends Node2D

signal dropped_resource()

func _on_CombinatorSlot1_drop_resource():
	emit_signal("dropped_resource")

func _on_CombinatorSlot2_drop_resource():
	emit_signal("dropped_resource")

func _on_CombinatorSlot3_drop_resource():
	emit_signal("dropped_resource")

