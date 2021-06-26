extends Node2D

signal close_book
signal close_book_to_day_display(is_left)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var had_failure = false

const MAX_DAY = 6

var index = 0
var pagenumbers = [
	"Day0",
	"WelcomePurpose",
	"CustomersIngredients",
	"Joiner",
	"Trashcan",
	"Cauldron",
	"FireLevels",
	"CoalBellows",
	"Mortar",
	"Spiralmouth",
	"Ingredients",
	"AwesomeMaid",
	"BurnersMermaid",
	"BlossomSpice",
	"FangVengeance",
	"BehemothPlasma",
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

func add_sucess_page(day): 
	if had_failure: 
		change_page_to(1)
		pagenumbers.remove(0)
		had_failure = false
	if day == MAX_DAY: 
		change_page_to(0)
		pagenumbers.insert(MAX_DAY, "DayN")
		change_page_to(MAX_DAY)
		return
	elif day > MAX_DAY:
		change_page_to(MAX_DAY)
		return
	change_page_to(0)
	pagenumbers.insert(day, "Day" + str(day))
	change_page_to(day)

func add_failure_page(day): 
	if had_failure: 
		change_page_to(0)
		return
	had_failure = true
	get_node(pagenumbers[index]).visible = false
	index = 0
	pagenumbers.insert(0, "FAIL")
	get_node(pagenumbers[0]).visible = true

func change_page_to(page): 
	var cur_index = index
	index = page
	set_page_based_on_index(cur_index)
		
func left_action(): 
	$BookFlipSound.play()
	if index > 0:
		index -= 1
	else: 
		index = pagenumbers.size() - 1

func right_action(): 
	$BookFlipSound.play()
	if index < pagenumbers.size() - 1:
		index += 1
	else: 
		index = 0
		
func space_action(): 
	$BookFlipSound.play()
	var book_start = pagenumbers.find("WelcomePurpose")
	var day_goal = book_start - 1
	var recipe_start = pagenumbers.find("Ingredients")
	if index < book_start: 
		index = book_start
	elif index < recipe_start: 
		index = recipe_start
	else: 
		index = day_goal

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
