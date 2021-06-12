extends Node2D

signal drag_resource



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ResourceArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		create_resource_drag()

func create_resource_drag(): 
	emit_signal("drag_resource")


func _on_ResourceArea_area_entered(area):
	if area.name == "HoverHackArea":
		$RichTextLabel.visible = true

func _on_ResourceArea_area_exited(area):
	if area.name == "HoverHackArea":
		$RichTextLabel.visible = false

