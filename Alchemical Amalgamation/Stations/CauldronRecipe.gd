extends Node

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

func _ready():
	pass # Replace with function body.

enum Heat {
	DEAD,
	LOW,
	MED,
	HIGH,
	BLAZE,
}

class Recipe:
	var Ingredient : int
	var BoilTime: int
	var Output: int
	var MinHeat: int
	var MaxHeat: int
	
var recipes = [
	create_recipe(ResourceType.MERMAID, 10, ResourceType.DILUTE_AWESOME, 
		Heat.LOW, Heat.BLAZE),
]

var CRAP_RECIPE = create_recipe(ResourceType.CRAP, 10, ResourceType.CRAP, 
		Heat.DEAD, Heat.BLAZE)

func create_recipe(ingredient, boil_time, output, min_heat, max_heat): 
	var recipe = Recipe.new()
	recipe.Ingredient = ingredient
	recipe.BoilTime = boil_time
	recipe.Output = output
	recipe.MinHeat = min_heat
	recipe.MaxHeat = max_heat
	return recipe

func recipe_for(ingredient): 
	for recipe in recipes: 
		var rec_ingredient = recipe.Ingredient	
		if ingredient == rec_ingredient: 
			print("GOOD RECIPE")
			return recipe
	print("CRAP RECIPE")
	return CRAP_RECIPE

#func recipe_for(ingredient): 
#	for recipe in recipes: 
#		var rec_ingredient = recipe.Ingredient	
#		if ingredient == rec_ingredient: 
#			return recipe
#	return ResourceType.CRAP
