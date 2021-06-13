extends Node2D

signal drag_resource(resource_type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_ResourceForShelf_drag_resource(resource_type):
	emit_signal("drag_resource", resource_type)
