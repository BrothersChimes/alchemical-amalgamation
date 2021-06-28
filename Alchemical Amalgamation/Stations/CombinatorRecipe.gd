extends Node

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType


class Recipe:
	var Ingredients : Array
	var Output: int
	
var recipes_for_book = [
	create_recipe(ResourceType.WATER, ResourceType.AWESOME, ResourceType.NONE, ResourceType.LIQUID_AWESOME),
	create_recipe(ResourceType.ETTERCAP, ResourceType.MERMAID, ResourceType.NONE, ResourceType.MAIDS_CAP),
	create_recipe(ResourceType.MAIDS_CAP, ResourceType.FLAMING_BLOSSOM, ResourceType.AWESOME, ResourceType.BURNERS_HAIR),
	create_recipe(ResourceType.BURNERS_HAIR, ResourceType.FLAMING_BLOSSOM, ResourceType.BEHEMOTH, ResourceType.IRON_SPICE),
	create_recipe(ResourceType.DRAGON_SAUCE, ResourceType.FANG_SHARD, ResourceType.NONE, ResourceType.DRAGON_BITE),
	create_recipe(ResourceType.ESSENCE_DRAGON, ResourceType.FANG_SHARD, ResourceType.VENGEANCE_POWDER, ResourceType.REVENGE_DRAGON),
	create_recipe(ResourceType.WERE_JELLY, ResourceType.GENIUS_BLISTER, ResourceType.NONE, ResourceType.STICKY_SAUCE),
	create_recipe(ResourceType.CARBUNCLE, ResourceType.WATER, ResourceType.NONE, ResourceType.BARNACLE_PASTE),
	create_recipe(ResourceType.BARNACLE_PASTE, ResourceType.STICKY_SAUCE, ResourceType.STUNBRICK, ResourceType.PESTLE_MORTAR),
	create_recipe(ResourceType.MELTED_SPICE, ResourceType.BRAIN_BRAN, ResourceType.NONE, ResourceType.HARDENED_SPICE),
]

func recipes_for_book(): 
	return recipes_for_book

func create_recipe(ingredient1, ingredient2, ingredient3, output): 
	var recipe = Recipe.new()
	recipe.Ingredients = [ingredient1, ingredient2, ingredient3]
	recipe.Output = output
	return recipe

func recipe_for(ingredients): 
	var sorted_array = ingredients.duplicate()
	sorted_array.sort()
	
	if ingredients[0] == ResourceType.NONE and \
		ingredients[1] == ResourceType.NONE and  \
		ingredients[2] == ResourceType.NONE:
			return  ResourceType.NONE
	
	for recipe in recipes_for_book: 
		var rec_ingredients = recipe.Ingredients.duplicate()
		rec_ingredients.sort() 
	
		if sorted_array == rec_ingredients: 
			return recipe.Output
	
	return ResourceType.CRAP
