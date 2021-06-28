extends Node2D

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

enum Heat {
	DEAD,
	LOW,
	MED,
	HIGH,
	BLAZE,
}

var min_heat
var max_heat

func _ready():
	$BookSprite.visible = false
	
const ANIM_TIME = 1
var cur_anim = 0
var cur_frame = 0

func _process(delta): 
	if min_heat == null or max_heat == null: 
		return 
	cur_anim += delta
	if cur_anim >= ANIM_TIME: 
		cur_anim = 0
		cur_frame += 1 
		if cur_frame > max_heat: 
			cur_frame = min_heat
		print("Min heat: " + str(min_heat))
		print("Max heat: " + str(min_heat))
		print("cur_frame: " + str(cur_frame))
		print("cur_anim: " + str(cur_anim))
		$Fire.frame = cur_frame
	
func set_page(cauldron_recipe):
	var ingredient = cauldron_recipe.Ingredient
	var output = cauldron_recipe.Output
	min_heat = cauldron_recipe.MinHeat
	max_heat = cauldron_recipe.MaxHeat
	cur_anim = min_heat
	
	$Title.text = ResourceTypeFile.display_name(output)
	$TitleSprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(output))
	
	var ingredient_name = ResourceTypeFile.display_name(ingredient)
	var text = "Boil one " + ingredient_name + " over a " + generate_heat_text(min_heat) \
		 + " to " + generate_heat_text(max_heat) + " fire until ready."
	
	$Line2.text = text
	$Line2Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(ingredient))

func generate_heat_text(heat): 
	match heat: 
		Heat.DEAD:
			return "dead"
		Heat.LOW:
			return "low"
		Heat.MED:
			return "medium"
		Heat.HIGH:
			return "hot"
		Heat.BLAZE:
			return "blazing"
			
