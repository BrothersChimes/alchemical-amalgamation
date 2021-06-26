extends Node2D

var text_timer = 0
var text_screen_time = 0.5

func _process(delta): 
	text_timer += delta
	if text_timer > text_screen_time: 
		set_text_none()
	
func set_text_success(sale_price, rep): 
	$SuccessText.visible = true
	$PriceText.visible = true
	$PriceText.text = str(sale_price) + "gp" #, " + str(rep) + " rep"
	$FailText.visible = false
	$HappySound.play()
	text_timer = 0
	
func set_text_failure(sale_price, rep): 
	$SuccessText.visible = false
	$PriceText.visible = true
	$PriceText.text = "-" + str(sale_price) + "gp" #, -" + str(rep) + " rep"
	$FailText.visible = true
	$UnhappySound.play()
	text_timer = 0
	
func set_text_none(): 
	$SuccessText.visible = false
	$PriceText.visible = false
	$FailText.visible = false
