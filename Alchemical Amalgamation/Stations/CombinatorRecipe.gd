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
	create_recipe(ResourceType.WATER, ResourceType.AWESOME, ResourceType.NONE, 
	ResourceType.DILUTE_AWESOME),
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
