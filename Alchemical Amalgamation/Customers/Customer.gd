extends Node2D

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType
var desired_resource_type 

export var customer_number = 0

var is_active = true

signal  click_on_customer(number)
signal time_expired(number)

func _ready(): 
	$AltText/AltTextLabel.visible = false
	
func _process(delta): 
	if is_active:
		$ProgressBar.value -= delta*0.5 # About 3 minutes
		if $ProgressBar.value <= 0: 
			emit_signal("time_expired", customer_number)
		# NEED UNIQUE STYLE BOXES TO USE THIS
#		var r = range_lerp($ProgressBar.value, 1, 100, 1, 0)
#		var g = range_lerp($ProgressBar.value, 1, 100, 0, 1)
#		var styleBox = $ProgressBar.get("custom_styles/fg")
#		styleBox.bg_color = Color(r, g, 0)
		
		
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("click_on_customer", customer_number)

func set_customer_message_and_item(message,resource_type): 
	is_active = true
	desired_resource_type = resource_type
	$RichTextLabel.text = message
	visible = true
	$ItemPlacement/Sprite.texture = load(ResourceTypeFile.sprite_path_for_resource_type(resource_type))
	$ProgressBar.value = 80 + randf()*20
	
func remove_customer(): 
	visible = false
	# is_active = false

func _on_AltTextArea_area_entered(area):
	if area.name == "HoverHackArea":
		if desired_resource_type != ResourceType.NONE:
			$AltText/AltTextLabel.text = ResourceTypeFile.display_name(desired_resource_type) + ": " + str(ResourceTypeFile.sale_price_for(desired_resource_type)) + "gp"
			$AltText/AltTextLabel.visible = true

func _on_AltTextArea_area_exited(area):
	if area.name == "HoverHackArea":
		$AltText/AltTextLabel.visible = false

