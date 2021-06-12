extends Node2D

signal drag_resource
signal destroy_resource

func _ready():
	pass # Replace with function body.

func _on_IngredientsShelf_drag_resource():
	emit_signal("drag_resource")

func _on_WasteBasket_destroy_resource():
	emit_signal("destroy_resource")
