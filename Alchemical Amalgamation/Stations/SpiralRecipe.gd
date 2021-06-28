extends Node

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

class Recipe:
	var Ingredient : int
	var Output: int
	
var recipes = [
	create_recipe(ResourceType.ECTOPLASM,ResourceType.ECTO_PLASMA),
	create_recipe(ResourceType.LIQUID_AWESOME,ResourceType.AWESOME),	create_recipe(ResourceType.MELTED_SPICE, ResourceType.DIAMOND_SPICE),
	create_recipe(ResourceType.DRAGON_SAUCE, ResourceType.ESSENCE_DRAGON),
]

var CRAP_RECIPE = create_recipe(ResourceType.CRAP, ResourceType.CRAP)

func recipes(): 
	return recipes

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
