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
	BRAINBARK,
	HONEY,
	STUNBRICK,
	CRAP,
	LIQUID_AWESOME,
	BOILED_MERMAID,
	MAIDS_CAP,
	BURNERS_HAIR,
	FLAMING_BLOSSOM,
	IRON_SPICE
}

static func is_resource_raw(resource_type): 
	return resource_type > ResourceType.NONE and resource_type < ResourceType.CRAP
	
static func is_resource_potion(resource_type): 
	return resource_type >= ResourceType.CRAP

static func sprite_path_for_resource_type(resource_type): 
	var resource_name = sprites_names_for_resource_types(resource_type)
	if is_resource_potion(resource_type): 
		return "res://Assets/Ingredients/potion_" + resource_name + ".png"
	return "res://Assets/Ingredients/ingredient_" + resource_name + ".png"
	
static func display_name(resource_type): 
	match resource_type:
		#### RAW MATERIALS ####
		ResourceType.AWESOME:
			return "Pure Awesome"	
		ResourceType.BEHEMOTH:
			return "Behemoth Tooth"	
		ResourceType.BLOSSOM:
			return "Blossom"	
		ResourceType.ECTOPLASM:
			return "Ectoplasm"	
		ResourceType.ETTERCAP:
			return "Ettercap"
		ResourceType.RIDDLER:
			return "Riddler"
		ResourceType.MERMAID:
			return "Mermaid Horn"
		ResourceType.WATER: 
			return "Distilled Water"
		ResourceType.BRAINBARK:
			return "Brainbark"
		ResourceType.HONEY:
			return "Honey"
		ResourceType.STUNBRICK:
			return "Stunbrick"
		#### POTIONS ####
		ResourceType.CRAP:
			return "Failed Potion"
		ResourceType.LIQUID_AWESOME:
			return "Liquid Awesome"
		ResourceType.BOILED_MERMAID:
			return "Boiled Mermaid"
		ResourceType.MAIDS_CAP:
			return "Maid's Cap"
		ResourceType.BURNERS_HAIR:
			return "Burner's Hair"
		ResourceType.FLAMING_BLOSSOM:
			return "Orange Blossom"
		ResourceType.IRON_SPICE:
			return "Iron Spice"

static func buy_price_for(resource_type): 
	if not is_resource_raw(resource_type): 
		return 0
	match resource_type:
		#### RAW MATERIALS ####
		ResourceType.AWESOME:
			return 15	
		ResourceType.BEHEMOTH:
			return 80	
		ResourceType.BLOSSOM:
			return 20	
		ResourceType.ECTOPLASM:
			return 80	
		ResourceType.ETTERCAP:
			return 5
		ResourceType.RIDDLER:
			return 50
		ResourceType.MERMAID:
			return 10
		ResourceType.WATER: 
			return 2
		ResourceType.BRAINBARK:
			return 100
		ResourceType.HONEY:
			return 120
		ResourceType.STUNBRICK:
			return 200

static func sale_price_for(resource_type): 
	if is_resource_raw(resource_type): 
		return int(buy_price_for(resource_type)*1.5)
	#### POTIONS ####
	match resource_type:
		ResourceType.CRAP:
			return 0
		ResourceType.LIQUID_AWESOME:
			return 40
		ResourceType.BOILED_MERMAID:
			return 40
		ResourceType.MAIDS_CAP:
			return 32
		ResourceType.BURNERS_HAIR:
			return 50
		ResourceType.FLAMING_BLOSSOM:
			return 100
		ResourceType.IRON_SPICE:
			return 200
	
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
		ResourceType.BRAINBARK:
			return "brainbark"
		ResourceType.HONEY:
			return "honey"
		ResourceType.STUNBRICK:
			return "stunbrick"
		#### POTIONS ####
		ResourceType.CRAP:
			return "yellow"
		ResourceType.LIQUID_AWESOME:
			return "green"
		ResourceType.BOILED_MERMAID:
			return "green"
		ResourceType.MAIDS_CAP:
			return "purple"
		ResourceType.BURNERS_HAIR:
			return "teal"
		ResourceType.FLAMING_BLOSSOM:
			return "orange"
		ResourceType.IRON_SPICE:
			return "orange"
