extends Node2D

# TODO this would work better as a state enum
var is_book_open = false
var is_day_display_open = true

var game_controller
var book
var day_display

var day = 0

func _ready():
	print("DAY: " + str(day))
	game_controller = $GameController
	game_controller.visible = true
	book = $Book
	book.visible = true
	day_display = $DayDisplay
	day_display.visible = true
	remove_child(game_controller)
	remove_child(book)
	# remove_child(day_display)

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
	if day_display.is_success_fail_display_open: 
		day_display.go_to_day(day)
		return
	day_display.is_success_fail_display_open = true
	remove_child(day_display)
	game_controller.setup_for_day(day)
	is_day_display_open = false
	is_book_open = false
	$BookCloseSound.play()
	add_child(game_controller)

func close_book_to_day_display(is_left):
	day_display.is_success_fail_display_open = false
	day_display.go_to_day(day)
	is_day_display_open = true
	is_book_open = false
	$BookCloseSound.play()
	add_child(day_display)
	remove_child(book)
	
func close_day_display_open_book(is_left): 
	day_display.is_success_fail_display_open = false
	is_day_display_open = false
	is_book_open = true
	if is_left:
		print("IS LEFT")
		book.set_to_last_page()
	else: 
		print("IS RIGHT")
		book.set_to_first_page()
	add_child(book)
	remove_child(day_display)
	$BookOpenSound.play()
	$BookCloseSound.stop()

func _on_GameController_end_day(is_success, gold, rep):
	close_both()
	day_display.set_success(is_success, gold, rep)
	if is_success:
		day += 1
	is_day_display_open = true
	add_child(day_display)

func _on_DayDisplay_close_day_display():
	close_day_display()

func _on_DayDisplay_close_day_display_to_book(is_left):
	close_day_display_open_book(is_left)

func _on_Book_close_book_to_day_display(is_left):
	close_book_to_day_display(is_left)
