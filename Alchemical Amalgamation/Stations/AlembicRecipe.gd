extends Node

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

class Recipe:
	var Ingredient : int
	var Output: int
	
var recipes = [
	create_recipe(ResourceType.FLAMING_BLOSSOM, ResourceType.DRAGON_SAUCE),
	create_recipe(ResourceType.HONEY, ResourceType.WERE_JELLY),
	create_recipe(ResourceType.IRON_SPICE, ResourceType.MELTED_SPICE),
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
