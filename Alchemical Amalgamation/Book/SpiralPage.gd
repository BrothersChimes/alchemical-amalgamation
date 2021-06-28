extends Node2D

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

func _ready():
	$BookSprite.visible = false
	
func set_page(spiral_recipe):
	var ingredient = spiral_recipe.Ingredient
	var output = spiral_recipe.Output
	
	$Title.text = ResourceTypeFile.display_name(output)
	$TitleSprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(output))
	$Line2.text = ResourceTypeFile.display_name(ingredient)
	$Line2Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(ingredient))
