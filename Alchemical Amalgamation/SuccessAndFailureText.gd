extends Node2D

var text_timer = 0
var text_screen_time = 0.5

func _process(delta): 
	text_timer += delta
	if text_timer > text_screen_time: 
		set_text_none()
	
func set_text_success(): 
	$SuccessText.visible = true
	$FailText.visible = false
	text_timer = 0
	
func set_text_failure(): 
	$SuccessText.visible = false
	$FailText.visible = true
	text_timer = 0
	
func set_text_none(): 
	$SuccessText.visible = false
	$FailText.visible = false
