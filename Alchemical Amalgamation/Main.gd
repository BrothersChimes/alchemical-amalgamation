extends Node2D

# TODO this would work better as a state enum
var is_book_open = true
var is_music_on = true

var game_controller
var book

var day = 0

func _ready():
	print("DAY: " + str(day))
	game_controller = $GameController
	game_controller.visible = true
	book = $Book
	book.visible = true
	remove_child(game_controller)
	$MusicCobweb.play()

func _on_GameController_open_book():
	open_book()
	
func _on_Book_close_book():
	close_book()

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
	$BookOpenSound.play()
	$BookCloseSound.stop()
	# $MusicController.visible = false
	
func close_book():
	is_book_open = false
	add_child(game_controller)
	remove_child(book)
	$BookOpenSound.stop()
	$BookCloseSound.play()
	# $MusicController.visible = true
	
func _on_GameController_end_day(is_success, gold, rep):
	if is_success:
		day += 1
		book.add_sucess_page(day)
	else: 
		book.add_failure_page(day)
	open_book()


func _on_MusicControllerArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		if is_music_on:
			$GameController/MusicController.music_off()
			is_music_on = false
			$MusicCobweb.stop()
		else: 
			$GameController/MusicController.music_on()
			is_music_on = true
			$MusicCobweb.play()
		
