extends Node2D

signal close_day_display

var index = 0
var pagenumbers = [
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
	pass
	
func _process(delta):
	pass

func set_day(day): 
	$NextDayPage/Left/Title.text = "Day " + str(day) + " ended"

func _on_CloseArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("close_day_display")
