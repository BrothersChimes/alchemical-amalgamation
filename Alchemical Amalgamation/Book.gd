extends Node2D

signal close_book
signal close_book_to_day_display(is_left)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var had_failure = false

const MAX_DAY = 7

var index = 1

var pagenumbers = [
	"Credits",
	"Day0",
	"WelcomePurpose",
	"CustomersIngredients",
	"Joiner",
	"Trashcan",
	"ShelfStore",
	"Cauldron",
	"FireLevels",
	"CoalBellows",
	"Mortar",
	"Spiralmouth",
	"AlembicAludel",
	"Ingredients",
]

func _ready():
	get_node(pagenumbers[1]).visible = true
	for page in pagenumbers:
		get_node(page).visible = false
	get_node(pagenumbers[1]).visible = true
	
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
		change_page_to(2)
		pagenumbers.remove(1)
		had_failure = false
	if day == MAX_DAY: 
		change_page_to(1)
		pagenumbers.insert(MAX_DAY, "DayN")
		change_page_to(MAX_DAY)
		return
	elif day > MAX_DAY:
		change_page_to(MAX_DAY)
		return
	change_page_to(1)
	pagenumbers.insert(day+1, "Day" + str(day))
	change_page_to(day+1)

func add_failure_page(day): 
	if had_failure: 
		change_page_to(1)
		return
	had_failure = true
	get_node(pagenumbers[index]).visible = false
	index = 1
	pagenumbers.insert(1, "FAIL")
	get_node(pagenumbers[1]).visible = true

func change_page_to(page): 
	var cur_index = index
	index = page
	set_page_based_on_index(cur_index)
		
func left_action(): 
	$BookFlipSound.play()
	if index > 0:
		index -= 1
	else: 
		index = pagenumbers.size() - 1 + $BookPair.num_pages()

func right_action(): 
	$BookFlipSound.play()
	if index < pagenumbers.size() - 1 + $BookPair.num_pages():
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
	if cur_index == index:
		return 
		
	if cur_index < pagenumbers.size() and index < pagenumbers.size():
		get_node(pagenumbers[cur_index]).visible = false
		get_node(pagenumbers[index]).visible = true
	elif cur_index < pagenumbers.size() and index >= pagenumbers.size():
		get_node(pagenumbers[cur_index]).visible = false
		set_recipe_page()
		$BookPair.visible = true
	elif cur_index >= pagenumbers.size() and index >= pagenumbers.size():
		#$BookPair.visible = true
		set_recipe_page()
		pass
	elif cur_index >= pagenumbers.size() and index < pagenumbers.size():
		get_node(pagenumbers[index]).visible = true
		$BookPair.visible = false

func set_recipe_page(): 
	var recipe_index = index - pagenumbers.size()
	print("RECIPE INDEX: " + str(recipe_index))
	$BookPair.set_recipe_page_to(recipe_index)

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
