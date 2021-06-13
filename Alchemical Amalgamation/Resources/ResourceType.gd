extends Node

enum ResourceType { 
	NONE,
	WATER,
	ETTERCAP,
	MERMAID,
	AWESOME,
	CRAP,
	DILUTE_AWESOME
}

static func is_resource_potion(resource_type): 
	return resource_type >= ResourceType.CRAP

static func sprite_path_for_resource_type(resource_type): 
	var resource_name = sprites_names_for_resource_types(resource_type)
	if is_resource_potion(resource_type): 
		return "res://Assets/Ingredients/potion_" + resource_name + ".png"
	return "res://Assets/Ingredients/ingredient_" + resource_name + ".png"
	
	
static func sprites_names_for_resource_types(resource_type): 
	match resource_type:
		#### RAW MATERIALS ####
		ResourceType.WATER: 
			return "water"
		ResourceType.ETTERCAP:
			return "etter"
		ResourceType.MERMAID:
			return "mermaid"
		ResourceType.AWESOME:
			return "awesome"	
		#### POTIONS ####
		ResourceType.CRAP:
			return "yellow"
		ResourceType.DILUTE_AWESOME:
			return "green"
