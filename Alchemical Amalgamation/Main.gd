extends Node2D

var is_book_open = false

var game_controller
var book

func _ready():
	game_controller = $GameController
	book = $Book
	book.visible = true
	remove_child(book)

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
	add_child(book)
	remove_child(game_controller)
	
func close_book():
	is_book_open = false
	add_child(game_controller)
	remove_child(book)
