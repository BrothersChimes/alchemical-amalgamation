extends Node2D

signal close_day_display
signal close_day_display_to_book(is_left)

var is_success_fail_display_open = false
var old_index = 0
var day = 0
var pagenumbers = [
	"Day0",
	"Day1",
	"Day2",
	"Day3",
	"Day4",
	"Day5",
	"DayN",
	"SUCCESS",
	"FAIL",
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
	var is_success_fail_display_open = false
	
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		left_action()
	if Input.is_action_just_pressed("ui_right"):
		right_action()

func left_action(): 
	$BookFlipSound.play() 
	emit_signal("close_day_display_to_book", true)
		
func right_action(): 
	$BookFlipSound.play()
	emit_signal("close_day_display_to_book", false)
	
func set_success(is_success, gold, rep): 
	$PreviousButton.visible = false	
	$NextButton.visible = false
	if is_success: 
#		set_page_based_on_index(7)
#		$SUCCESS/Left/Line3.text = "You had " + str(gold) + "gp."
#		$SUCCESS/Left/Line4.text = "You had " + str(rep) + " rep."
		emit_signal("close_day_display")
	else: 
		set_page_based_on_index(8)
		$FAIL/Left/Line3.text = "You had " + str(gold) + "gp."
		$FAIL/Left/Line4.text = "You had " + str(rep) + " rep."
		
func go_to_day(new_day): 
	day = new_day
	var max_day = pagenumbers.size()-2
	if day >= max_day-1:
		$DayN/Left/Title.text = "Day " + str(day)
		set_page_based_on_index(max_day - 1)
		return
	set_page_based_on_index(day)
	is_success_fail_display_open = false
	$PreviousButton.visible = true
	$NextButton.visible = true
	
func set_page_based_on_index(new_index): 
	get_node(pagenumbers[old_index]).visible = false
	get_node(pagenumbers[new_index]).visible = true
	old_index = new_index
	
func _on_CloseArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("close_day_display")

func _on_NextArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		if not is_success_fail_display_open:
			emit_signal("close_day_display_to_book", false)
		else: 
			emit_signal("close_day_display")

func _on_PreviousArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		if not is_success_fail_display_open:
			emit_signal("close_day_display_to_book", true)
		else: 
			emit_signal("close_day_display")

