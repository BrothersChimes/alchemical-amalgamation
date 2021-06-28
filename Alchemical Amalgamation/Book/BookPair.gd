extends Node2D

const CombinatorRecipe = preload("res://Stations/CombinatorRecipe.gd")
const MortarRecipe = preload("res://Stations/MortarRecipe.gd")

var combinator_recipes
var mortar_recipes

func _ready(): 
	var combinator_recipe = CombinatorRecipe.new()
	combinator_recipes = combinator_recipe.recipes_for_book()
	var mortar_recipe = MortarRecipe.new()
	mortar_recipes = mortar_recipe.recipes()
	$BookSprite.visible = false
	
func num_pages(): 
	return (mortar_recipes.size()+1)/2

enum RecipeType {
	COMBINATOR,
	CAULDRON,
	MORTAR,
	ALEMBIC,
	SPIRAL
}

class RecipePage:
	var RecipeType
	var Recipe

func set_recipe_page_to(page_index):
	print("SET RECIPE PAGE TO: " + str(page_index))
	var left_page_index = page_index*2
	var right_page_index = page_index*2+1
	set_left_page(mortar_recipes[left_page_index])
	
	if mortar_recipes.size() <= right_page_index:
		set_right_page_blank()
		return
	
	set_right_page(mortar_recipes[right_page_index])
	
func set_left_page(combinator_recipe):
	# $CombinatorPageLeft.set_page(combinator_recipe)
	$MortarPageLeft.set_page(combinator_recipe)
	
func set_right_page(combinator_recipe): 
	# $CombinatorPageRight.set_page(combinator_recipe)
	$MortarPageRight.visible = true
	$MortarPageRight.set_page(combinator_recipe)

func set_right_page_blank():
	$MortarPageRight.visible = false
