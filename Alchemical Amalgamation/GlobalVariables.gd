extends Node2D

var test_string = "Hello!"
var ResourceDrag = preload("res://Resources/ResourcePlaced.tscn") # resource is loaded at compile time

var is_carrying_item  = false

enum Resources { 
	WATER
}

func get_resource(resource): 
	if resource == Resources.WATER: 
		var resource_drag = ResourceDrag.instance()
		resource_drag.resource_type = resource
		return resource_drag
