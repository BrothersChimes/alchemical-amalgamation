extends Node

enum ResourceType { 
	NONE,
	ETTERCAP,
	MERMAID,
	AWESOME,
	BLOSSOM,
	BEHEMOTH,
	ECTOPLASM,
	RIDDLER,
	WATER,
	CRAP,
	LIQUID_AWESOME,
	BOILED_MERMAID,
	MAIDS_CAP,
	BURNERS_HAIR,
	FLAMING_BLOSSOM,
	IRON_SPICE
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
		ResourceType.AWESOME:
			return "awesome"	
		ResourceType.BEHEMOTH:
			return "behemoth"	
		ResourceType.BLOSSOM:
			return "blossom"	
		ResourceType.ECTOPLASM:
			return "ectoplasm"	
		ResourceType.ETTERCAP:
			return "etter"
		ResourceType.RIDDLER:
			return "riddler"
		ResourceType.MERMAID:
			return "mermaid"
		ResourceType.WATER: 
			return "water"
		#### POTIONS ####
		ResourceType.CRAP:
			print("RETURNING CRAP: " + str(ResourceType.CRAP))
			return "yellow"
		ResourceType.LIQUID_AWESOME:
			return "green"
		ResourceType.BOILED_MERMAID:
			print("RETURNING BOILED_MERMAID: " + str(ResourceType.BOILED_MERMAID))
			return "green"
		ResourceType.MAIDS_CAP:
			return "purple"
		ResourceType.BURNERS_HAIR:
			return "teal"
		ResourceType.FLAMING_BLOSSOM:
			return "orange"
		ResourceType.IRON_SPICE:
			return "orange"
