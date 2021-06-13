extends Node2D

func add_ingredient_to_spiralmouth():
	get_node("SpiralmouthInUse").visible = true
	get_node("SpiralmouthFinished").visible = false

func finish_spiralmouth():
	get_node("SpiralmouthInUse").visible = false
	get_node("SpiralmouthFinished").visible = true

func empty_spiralmouth():
	get_node("SpiralmouthInUse").visible = false
	get_node("SpiralmouthFinished").visible = false
