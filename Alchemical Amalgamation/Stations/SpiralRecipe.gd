extends Node

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

class Recipe:
	var Ingredient : int
	var Output: int
	
var recipes = [
	create_recipe(ResourceType.ETTERCAP,ResourceType.ETTERCAP),
	create_recipe(ResourceType.MERMAID,ResourceType.FANG_SHARD),
	create_recipe(ResourceType.RIDDLER, ResourceType.VENGEANCE_POWDER),
	create_recipe(ResourceType.BEHEMOTH,ResourceType.BEHEMOTH_DUST),
]

var CRAP_RECIPE = create_recipe(ResourceType.CRAP, ResourceType.CRAP)

func create_recipe(ingredient, output): 
	var recipe = Recipe.new()
	recipe.Ingredient = ingredient
	recipe.Output = output
	return recipe

func recipe_for(ingredient): 
	for recipe in recipes: 
		var rec_ingredient = recipe.Ingredient	
		if ingredient == rec_ingredient: 
			return recipe
	return CRAP_RECIPE
