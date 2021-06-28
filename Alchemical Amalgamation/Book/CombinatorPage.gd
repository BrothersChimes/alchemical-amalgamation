extends Node2D

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

func _ready():
	$BookSprite.visible = false
	
func set_page(combinator_recipe):
	var ingredients = combinator_recipe.Ingredients
	var output = combinator_recipe.Output
	
	$Title.text = ResourceTypeFile.display_name(output)
	$TitleSprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(output))
	
	setup_line($Line1, $Line1Sprite, ingredients[0])
	setup_line($Line2, $Line2Sprite, ingredients[1])
	setup_line($Line3, $Line3Sprite, ingredients[2])
	
func setup_line(text_line, sprite_line, resource): 
	if resource == ResourceType.NONE: 
		text_line.visible = false
		sprite_line.visible = false
		return
	text_line.visible = true
	sprite_line.visible = true	
	text_line.text = ResourceTypeFile.display_name(resource)
	sprite_line.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource))

class Recipe:
	var Ingredients : Array
	var Output: int
	
func create_recipe(ingredient1, ingredient2, ingredient3, output): 
	var recipe = Recipe.new()
	recipe.Ingredients = [ingredient1, ingredient2, ingredient3]
	recipe.Output = output
	return recipe
