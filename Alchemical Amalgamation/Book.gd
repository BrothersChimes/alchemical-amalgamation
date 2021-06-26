extends Node2D

signal close_book
signal close_book_to_day_display(is_left)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const RECIPE_START = 7
var index = 0
var pagenumbers = [
	"WelcomePurpose",
	"CustomersIngredients",
	"Joiner",
	"Trashcan",
	"Cauldron",
	"FireLevels",
	"CoalBellows",
	"Ingredients",
	"AwesomeMaid",
	"BurnersMermaid",
	"BlossomSpice",
	#"Page12",
	#"Page13",
	#"Page14",
	#"Page15",
	#"Page16",
	#"Page17",
	#"Page18",
	#"Page19",
	#"Page20",
	#"Page21",
	#"Page22",
	#"Page23",
	#"Page24",
	#"Page25",
	#"Page26",
	#"Page27",
	#"Page28",
	#"Page29",
	#"Page30"
]

func _ready():
	get_node(pagenumbers[0]).visible = true
	for page in pagenumbers:
		get_node(page).visible = false
	get_node(pagenumbers[0]).visible = true
	
func _process(delta):
	var cur_index = index
	if Input.is_action_just_pressed("ui_left"):
		left_action()
	if Input.is_action_just_pressed("ui_right"):
		right_action()
	if Input.is_action_just_pressed("bellows"):
		space_action()
	set_page_based_on_index(cur_index)

func left_action(): 
	$BookFlipSound.play()
	if index > 0:
		index -= 1
	else: 
		emit_signal("close_book_to_day_display", true)

func set_to_first_page(): 
	var cur_index = index
	index = 0
	set_page_based_on_index(cur_index)

func set_to_last_page(): 
	var cur_index = index 
	index = pagenumbers.size() - 1
	set_page_based_on_index(cur_index)
	
func right_action(): 
	$BookFlipSound.play()
	if index < pagenumbers.size() - 1:
		index += 1
	else: 
		emit_signal("close_book_to_day_display", false)
		
func space_action(): 
	$BookFlipSound.play()
	if index >= RECIPE_START:
		index = 0
	else:
		index = RECIPE_START	

func set_page_based_on_index(cur_index): 
	# print(index)
	# print(pagenumbers[index])
	if cur_index != index:
		get_node(pagenumbers[cur_index]).visible = false
		get_node(pagenumbers[index]).visible = true

func _on_PreviousArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var cur_index = index
		left_action()
		set_page_based_on_index(cur_index)
		
func _on_NextArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var cur_index = index
		right_action()
		set_page_based_on_index(cur_index)
		
func _on_CloseArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("close_book")
