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
	IRON_SPICE,
	FANG_SHARD,
	VENGEANCE_POWDER,
	BEHEMOTH_DUST,
	ECTO_PLASMA,
	DRAGON_SAUCE,
	REVENGE_DRAGON,
	ESSENCE_DRAGON,
	DRAGON_BITE,
	STICKY_SAUCE,
	BARNACLE_PASTE,
	WERE_JELLY,
	GENIUS_BLISTER,
	BARNACLE_PASTE, 
	PESTLE_MORTAR,
	HARDENED_SPICE,
	BRAIN_BRAN,
	CARBUNCLE,
	DUST_OF_DRYNESS,
	MELTED_SPICE,
	DIAMOND_SPICE,
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
		ResourceType.NONE:
			return ""
		ResourceType.AWESOME:
			return "Pure Awesome"	
		ResourceType.BEHEMOTH:
			return "Behemoth Scale"	
		ResourceType.BLOSSOM:
			return "Opulence Blossom"	
		ResourceType.ECTOPLASM:
			return "Haven Ghoul Ectoplasm"	
		ResourceType.ETTERCAP:
			return "Etter Cap"
		ResourceType.RIDDLER:
			return "Riddler's Vengeance"
		ResourceType.MERMAID:
			return "Mermaid Fang"
		ResourceType.WATER: 
			return "Aqua"
		ResourceType.BRAINBARK:
			return "Brainbark Stem"
		ResourceType.HONEY:
			return "Werewolf Honey"
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
			return "Flaming Blossom"
		ResourceType.IRON_SPICE:
			return "Iron Spice"
		ResourceType.FANG_SHARD:
			return "Fang Shards"
		ResourceType.VENGEANCE_POWDER:
			return "Vengeance Powder"
		ResourceType.BEHEMOTH_DUST:
			return "Behemoth Dust"
		ResourceType.ECTO_PLASMA:
			return "Ecto Plasma"
		ResourceType.DRAGON_SAUCE:
			return "Dragon Sauce"
		ResourceType.ESSENCE_DRAGON:
			return "Essence of the Dragon"
		ResourceType.REVENGE_DRAGON:
			return "Revenge of the Dragon"
		ResourceType.DRAGON_BITE:
			return "Dragon's Bite"
		ResourceType.STICKY_SAUCE:
			return "Sticky Sauce"
		ResourceType.WERE_JELLY:
			return "Were-jelly"
		ResourceType.GENIUS_BLISTER:
			return "Genius Blister"
		ResourceType.BARNACLE_PASTE: 
			return "Keel Haul"
		ResourceType.PESTLE_MORTAR:
			return "Pestle Mortar"
		ResourceType.HARDENED_SPICE:
			return "Hardened Spice"
		ResourceType.BRAIN_BRAN:
			return "Brain Bran"
		ResourceType.CARBUNCLE:
			return "Carbuncle"
		ResourceType.DUST_OF_DRYNESS:
			return "Dust of Dryness"
		ResourceType.MELTED_SPICE:
			return "Melted Spice"
		ResourceType.DIAMOND_SPICE:
			return "Diamond Spice"
			
static func buy_price_for(resource_type): 
	if not is_resource_raw(resource_type): 
		return 0
	match resource_type:
		#### RAW MATERIALS ####
		ResourceType.WATER: 
			return 1
		ResourceType.ETTERCAP:
			return 1
		ResourceType.MERMAID:
			return 2
		ResourceType.AWESOME:
			return 2	
		ResourceType.BLOSSOM:
			return 3	
		ResourceType.RIDDLER:
			return 3
		ResourceType.BEHEMOTH:
			return 5	
		ResourceType.ECTOPLASM:
			return 5	
		ResourceType.BRAINBARK:
			return 8
		ResourceType.HONEY:
			return 8
		ResourceType.STUNBRICK:
			return 13

static func sale_price_for(resource_type): 
	if is_resource_raw(resource_type): 
		return int((buy_price_for(resource_type)+1)*1.5)
	#### POTIONS ####
	match resource_type:
		ResourceType.CRAP:
			return 0
		ResourceType.LIQUID_AWESOME:
			return 10
		ResourceType.BOILED_MERMAID:
			return 20
		ResourceType.MAIDS_CAP:
			return 10
		ResourceType.BURNERS_HAIR:
			return 50
		ResourceType.FLAMING_BLOSSOM:
			return 15
		ResourceType.IRON_SPICE:
			return 100
		ResourceType.FANG_SHARD:
			return 10
		ResourceType.VENGEANCE_POWDER:
			return 10
		ResourceType.BEHEMOTH_DUST:
			return 15
		ResourceType.ECTO_PLASMA:
			return 50
		ResourceType.DRAGON_SAUCE:
			return 60
		ResourceType.ESSENCE_DRAGON:
			return 180
		ResourceType.REVENGE_DRAGON:
			return 290
		ResourceType.DRAGON_BITE:
			return 100
		ResourceType.STICKY_SAUCE:
			return 85
		ResourceType.BARNACLE_PASTE:
			return 90
		ResourceType.WERE_JELLY:
			return 20
		ResourceType.GENIUS_BLISTER:
			return 24
		ResourceType.PESTLE_MORTAR:
			return 380
		ResourceType.HARDENED_SPICE:
			return 350
		ResourceType.BRAIN_BRAN:
			return 20
		ResourceType.CARBUNCLE:
			return 40
		ResourceType.DUST_OF_DRYNESS:
			return 30
		ResourceType.MELTED_SPICE:
			return 200
		ResourceType.DIAMOND_SPICE:
			return 400

			
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
		ResourceType.FANG_SHARD:
			return "peach"
		ResourceType.VENGEANCE_POWDER:
			return "purple"
		ResourceType.BEHEMOTH_DUST:
			return "lavender"
		ResourceType.ECTO_PLASMA:
			return "bile"
		ResourceType.DRAGON_SAUCE:
			return "red"
		ResourceType.ESSENCE_DRAGON:
			return "brown"
		ResourceType.DRAGON_BITE:
			return "orange"
		ResourceType.REVENGE_DRAGON:
			return "purple"
		ResourceType.STICKY_SAUCE:
			return "lavender"
		ResourceType.BARNACLE_PASTE:
			return "teal"
		ResourceType.WERE_JELLY:
			return "green"
		ResourceType.GENIUS_BLISTER:
			return "lavender"
		ResourceType.PESTLE_MORTAR:
			return "peach"
		ResourceType.HARDENED_SPICE:
			return "brown"
		ResourceType.BRAIN_BRAN:
			return "brown"
		ResourceType.CARBUNCLE:
			return "peach"
		ResourceType.DUST_OF_DRYNESS:
			return "bile"
		ResourceType.MELTED_SPICE:
			return "red"
		ResourceType.DIAMOND_SPICE:
			return "teal"
