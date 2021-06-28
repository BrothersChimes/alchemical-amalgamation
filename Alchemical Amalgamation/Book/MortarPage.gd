extends Node2D

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

func _ready():
	$BookSprite.visible = false
	
func set_page(mortar_recipe):
	var ingredient = mortar_recipe.Ingredient
	var output = mortar_recipe.Output
	
	$Title.text = ResourceTypeFile.display_name(output)
	$TitleSprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(output))
	$Line2.text = ResourceTypeFile.display_name(ingredient)
	$Line2Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(ingredient))
