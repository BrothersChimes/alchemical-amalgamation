extends Node2D

const CombinatorRecipe = preload("res://Stations/CombinatorRecipe.gd")
const MortarRecipe = preload("res://Stations/MortarRecipe.gd")
const CauldronRecipe = preload("res://Stations/CauldronRecipe.gd")

var combinator_recipes
var cauldron_recipes
var mortar_recipes


func _ready(): 
	var combinator_recipe = CombinatorRecipe.new()
	combinator_recipes = combinator_recipe.recipes_for_book()
	var cauldron_recipe = CauldronRecipe.new()
	cauldron_recipes = cauldron_recipe.recipes()
	var mortar_recipe = MortarRecipe.new()
	mortar_recipes = mortar_recipe.recipes()
	$BookSprite.visible = false
	setup_recipe_pages()
	
func num_pages(): 
	return (recipe_pages.size()+1)/2

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
	
var recipe_pages = []

func setup_recipe_pages(): 
	for recipe in combinator_recipes: 
		recipe_pages.append(create_recipe(RecipeType.COMBINATOR, recipe))
	for recipe in cauldron_recipes: 
		recipe_pages.append(create_recipe(RecipeType.CAULDRON, recipe))
	for recipe in mortar_recipes: 
		recipe_pages.append(create_recipe(RecipeType.MORTAR, recipe))

		
func create_recipe(type, recipe):
	var recipe_page = RecipePage.new()
	recipe_page.RecipeType = type
	recipe_page.Recipe = recipe
	return recipe_page

func set_recipe_page_to(page_index):
	print("SET RECIPE PAGE TO: " + str(page_index))
	var left_page_index = page_index*2
	var right_page_index = page_index*2+1	
	set_left_page(recipe_pages[left_page_index])
	
	if right_page_index >= recipe_pages.size():
		set_right_page_blank()
		return
	
	set_right_page(recipe_pages[right_page_index])
	
func set_left_page(recipe_page):
	$CombinatorPageLeft.visible = false
	$CauldronPageLeft.visible = false
	$MortarPageLeft.visible = false

	
	if recipe_page.RecipeType == RecipeType.COMBINATOR:
		$CombinatorPageLeft.visible = true
		$CombinatorPageLeft.set_page(recipe_page.Recipe)
	elif recipe_page.RecipeType == RecipeType.CAULDRON:
		$CauldronPageLeft.visible = true
		$CauldronPageLeft.set_page(recipe_page.Recipe)
	elif recipe_page.RecipeType == RecipeType.MORTAR:
		$MortarPageLeft.visible = true
		$MortarPageLeft.set_page(recipe_page.Recipe)

func set_right_page(recipe_page): 
	$CombinatorPageRight.visible = false
	$MortarPageRight.visible = false
	$CauldronPageRight.visible = false
		
	if recipe_page.RecipeType == RecipeType.COMBINATOR:
		$CombinatorPageRight.visible = true
		$CombinatorPageRight.set_page(recipe_page.Recipe)
	elif recipe_page.RecipeType == RecipeType.CAULDRON:
		$CauldronPageRight.visible = true
		$CauldronPageRight.set_page(recipe_page.Recipe)
	elif recipe_page.RecipeType == RecipeType.MORTAR:
		$MortarPageRight.visible = true
		$MortarPageRight.set_page(recipe_page.Recipe)
		
func set_right_page_blank():
	$CauldronPageRight.visible = false
	$CombinatorPageRight.visible = false
	$MortarPageRight.visible = false
