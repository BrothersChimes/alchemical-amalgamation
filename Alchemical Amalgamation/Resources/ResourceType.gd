extends Node

enum ResourceType { 
	NONE,
	WATER,
	ETTERCAP,
	MERMAID,
	AWESOME
}

static func sprite_path_for_resource_type(resource_type): 
	var resource_name = sprites_names_for_resource_types(resource_type)
	return "res://Assets/Ingredients/ingredient_" + resource_name + ".png"
	
static func sprites_names_for_resource_types(resource_type): 
	match resource_type:
		ResourceType.WATER: 
			return "water"
		ResourceType.ETTERCAP:
			return "etter"
		ResourceType.MERMAID:
			return "mermaid"
		ResourceType.AWESOME:
			return "awesome"
