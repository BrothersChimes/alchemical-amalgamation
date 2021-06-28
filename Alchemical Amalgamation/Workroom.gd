extends Node2D

signal drag_resource_from_shelf(resource_type)
signal destroy_resource
signal click_on_combinator_slot(slot_num)
signal click_on_combinator_output
signal click_on_holding_resource(resource, number)

const NUM_HOLDERS = 4

func _ready():
	pass # Replace with function body.

func _on_WasteBasket_destroy_resource():
	emit_signal("destroy_resource")

func _on_Combinator_click_on_combinator_slot(slot_num):
	print("WORKROOM COMBINATOR SLOT " + str(slot_num) + " CLICKED")
	emit_signal("click_on_combinator_slot", slot_num)

func set_combinator_slot_to_item(slot_num, resource_type, output): 
	$Combinator.set_slot_to_item(slot_num, resource_type, output)

func _on_ResourceForShelf_drag_resource(resource_type):
	emit_signal("drag_resource_from_shelf", resource_type)

func _on_Combinator_click_on_combinator_output():
	emit_signal("click_on_combinator_output")

func _on_HolderForShelf_drag_resource(resource, number):
	emit_signal("click_on_holding_resource", resource, number)

# Returns true if there is an open spot, and then places the resource there
func place_resource_on_first_open_holder(resource): 
	for i in range(0, NUM_HOLDERS): 
		var holder = get_node("ShelfForIngredients/HolderForShelf" + str(i))
		if holder.is_empty(): 
			holder.set_resource_to(resource)
			return true
	return false
		
func set_holder_to(resource, number): 
	get_node("ShelfForIngredients/HolderForShelf" + str(number)).set_resource_to(resource)

func setup_for_day(day_num): 
	$ShelfForIngredients.setup_for_day(day_num)
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
	$station_woodpile.visible = false
	$station_coal.visible = false
	$station_shovel_empty.visible = false
	$Combinator.visible = false

func setup_for_day_1(): 
	$Combinator.visible = true
	
func setup_for_day_2(): 
	$station_woodpile.visible = true
	$station_coal.visible = true
	$station_shovel_empty.visible = true

func setup_for_day_3(): 
	pass

func setup_for_day_4(): 
	pass

func setup_for_final_days():
	pass
