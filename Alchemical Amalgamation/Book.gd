extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const RECIPE_START = 7
var index = 0
var pagenumbers = [
	"Page1",
	"Page2",
	"Page3",
	"Page4",
	"Page5",
	"Page6",
	"Page7",
	"Page8",
	"Page9",
	"Page10",
	"Page11",
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
	print(index)
	print(pagenumbers[index])
	if Input.is_action_just_pressed("ui_left"):
		if index > 0:
			index -= 1
	if Input.is_action_just_pressed("ui_right"):
		if index < pagenumbers.size() - 1:
			index += 1
	if Input.is_action_just_pressed("bellows"):
		if index >= RECIPE_START:
			index = 0
		else:
			index = RECIPE_START
	if cur_index != index:
		get_node(pagenumbers[cur_index]).visible = false
		get_node(pagenumbers[index]).visible = true
