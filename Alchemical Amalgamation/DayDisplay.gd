extends Node2D

signal close_day_display

var old_index = 0
var pagenumbers = [
	"Day0",
	"Day1",
	"Day2",
	"Day3",
	"Day4",
	"Day5",
	"DayN",
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
	
func set_day(day): 
	var max_day = pagenumbers.size()
	if day >= max_day-1:
		print("Day " + str(day) + " more than max" + str(max_day-1))
		$DayN/Left/Title.text = "End of Day " + str(day+1)
		set_page_based_on_index(max_day - 1)
		return
	print("SET DAY " + str(day))
	set_page_based_on_index(day)

func set_page_based_on_index(new_index): 
	get_node(pagenumbers[old_index]).visible = false
	get_node(pagenumbers[new_index]).visible = true
	old_index = new_index
	
func _on_CloseArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("close_day_display")
