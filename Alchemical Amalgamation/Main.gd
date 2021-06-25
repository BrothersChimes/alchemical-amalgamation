extends Node2D

# TODO this would work better as a state enum
var is_book_open = true
var is_day_display_open = false

var game_controller
var book
var day_display

var day = 0

func _ready():
	game_controller = $GameController
	game_controller.visible = true
	book = $Book
	book.visible = true
	day_display = $DayDisplay
	day_display.visible = true
	remove_child(game_controller)
	remove_child(day_display)

func _on_GameController_open_book():
	open_book()
	
func _on_Book_close_book():
	close_book()

func _process(delta):
	if Input.is_action_just_pressed("book"):
		if is_day_display_open: 
			close_day_display()
		else: 	
			if is_book_open:
				close_book()
			else: 
				open_book()
				
func open_book():
	is_book_open = true
	add_child(book)
	remove_child(game_controller)
	$BookOpenSound.play()
	$BookCloseSound.stop()
	
func close_book():
	is_book_open = false
	add_child(game_controller)
	remove_child(book)
	$BookOpenSound.stop()
	$BookCloseSound.play()
	
func close_both(): 
	if is_book_open: 
		remove_child(book)
	else: 
		remove_child(game_controller)
	
func close_day_display():
	remove_child(day_display)
	game_controller.setup_for_day(day)
	is_day_display_open = false
	is_book_open = false
	#$BookOpenSound.stop()
	$BookCloseSound.play()
	add_child(game_controller)

func _on_GameController_end_day():
	close_both()
	print("Ended day " + str(day))
	day += 1
	day_display.set_day(day)
	is_day_display_open = true
	add_child(day_display)

func _on_DayDisplay_close_day_display():
	close_day_display()

