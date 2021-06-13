extends Node2D

var is_book_open = false

func _ready():
	close_book()

func _on_GameController_open_book():
	open_book()

func _process(delta):
	if Input.is_action_just_pressed("book"):
		if is_book_open:
			close_book()
		else: 
			open_book()

func open_book():
	is_book_open = true
	$GameController.visible = false
	$GameController.set_process(false)
	$Book.visible = true
	$Book.set_process(true)
	
func close_book(): 
	is_book_open = false
	$GameController.visible = true
	$GameController.set_process(true)
	$Book.visible = false
	$Book.set_process(false)
