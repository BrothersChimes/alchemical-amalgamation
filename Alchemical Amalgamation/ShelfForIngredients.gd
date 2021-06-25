extends Node2D

func _ready():
	pass # Replace with function body.

func setup_for_day(day_num): 
	if day_num == 0: 
		setup_for_day_0()
	elif day_num == 1: 
		setup_for_day_1()
	elif day_num == 2: 
		setup_for_day_2()
	elif day_num == 3: 
		setup_for_day_3()
	elif day_num == 4: 
		setup_for_day_4()
	else: 
		setup_for_final_days()


func setup_for_day_0(): 
	$MermaidResource.visible = false
	$AwesomeResource.visible = false
	$Blossom.visible = false
	$Riddler.visible = false
	$Behemoth.visible = false
	$Ectoplasm.visible = false
	$Brainbark.visible = false
	$Honey.visible = false
	$Stunbrick.visible = false
		
func setup_for_day_1(): 
	$MermaidResource.visible = true
	$AwesomeResource.visible = true

func setup_for_day_2(): 
	$Blossom.visible = true
	$Riddler.visible = true

func setup_for_day_3(): 
	$Behemoth.visible = true
	$Ectoplasm.visible = true

func setup_for_day_4(): 
	$Brainbark.visible = true
	$Honey.visible = true
	
func setup_for_final_days(): 
	$Stunbrick.visible = true
	
