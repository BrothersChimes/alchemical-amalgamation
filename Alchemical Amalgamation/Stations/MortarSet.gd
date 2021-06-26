extends Node2D

signal mortar_click()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("mortar_click")

func slam_pestle(): 
	if $Pestle.frame == 0:
		$Pestle.frame = 1
	else: 
		$Pestle.frame = 0

func add_ingredient_to_mortar(): 
	$MortarEmpty.visible = false
	$MortarInUse.visible = true
	$MortarOutput.visible = false
	$Pestle.visible = true
	
func finish_mortar(): 
	$MortarEmpty.visible = true
	$MortarInUse.visible = false
	$MortarOutput.visible = true
	$Pestle.visible = false
	
func take_ingredient_from_mortar(): 
	$MortarEmpty.visible = true
	$MortarInUse.visible = false
	$MortarOutput.visible = false
	$Pestle.visible = false
	
