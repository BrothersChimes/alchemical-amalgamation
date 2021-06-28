extends Node

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

class Recipe:
	var Ingredients : Array
	var Output: int
	
var recipes = [
	create_recipe(ResourceType.NONE, ResourceType.NONE, ResourceType.NONE, ResourceType.NONE),
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

func create_recipe(ingredient1, ingredient2, ingredient3, output): 
	var recipe = Recipe.new()
	recipe.Ingredients = [ingredient1, ingredient2, ingredient3]
	recipe.Output = output
	return recipe

func recipe_for(ingredients): 
	var sorted_array = ingredients.duplicate()
	sorted_array.sort()
	
	for recipe in recipes: 
		var rec_ingredients = recipe.Ingredients.duplicate()
		rec_ingredients.sort() 
	
		if sorted_array == rec_ingredients: 
			return recipe.Output
	
	return ResourceType.CRAP
