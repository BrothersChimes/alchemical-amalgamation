extends Node2D

signal open_book


const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

const CombinatorRecipes = preload("res://Stations/CombinatorRecipe.gd")
var recipes = CombinatorRecipes.new()

var NOTHING = [ResourceType.NONE, ResourceType.NONE, ResourceType.NONE]
var resource_carried = ResourceType.NONE
var resource_combinator= [ResourceType.NONE, ResourceType.NONE, ResourceType.NONE]

var CustomersQueue = preload("res://Customers/CustomersQueue.gd")
var customersQueue = CustomersQueue.new()

var cauldron_contents = ResourceType.NONE

var customer_desired_resources = [
	ResourceType.NONE, ResourceType.NONE, ResourceType.NONE,
	ResourceType.NONE, ResourceType.NONE
]

func _ready():
	set_start_customer()

func set_start_customer(): 
	set_customers()

func set_customers(): 
	var queue = customersQueue.customers
	
	for i in range(0, customer_desired_resources.size()):
		if queue.empty():
			return
		var customer = customer_desired_resources[i]
		if customer != ResourceType.NONE:
			continue
		var next_customer = queue.front()
		customer_desired_resources[i] = next_customer.Desire
		$CustomerText.create_customer_with_message(i, next_customer.Message)
		queue.pop_front()

func _on_Workroom_drag_resource_from_shelf(resource_type):
	if resource_carried == ResourceType.NONE:
		set_carried_resource_to(resource_type)
		
func _on_Workroom_destroy_resource():
	set_carried_resource_to(ResourceType.NONE)
	
func _on_Workroom_drop_resource():
	set_carried_resource_to(ResourceType.NONE)
	
func _on_CustomerText_sell_potion_to(customer_number):
	if resource_carried == ResourceType.NONE:
		return
	if resource_carried == customer_desired_resources[customer_number]:
		print("SUCCESS!")
	else:
		print("FAILURE!")
	cycle_customer(customer_number)
	set_carried_resource_to(ResourceType.NONE)

func cycle_customer(customer_number): 
	$CustomerText.remove_customer(customer_number)
	customer_desired_resources[customer_number] = ResourceType.NONE
	set_customers()
	
func _on_Workroom_pick_up_resource(resource_type):
	if resource_carried == ResourceType.NONE:
		set_carried_resource_to(resource_type)

func _on_Workroom_click_on_combinator_slot(slot_num):
	print("MAIN COMBINATOR SLOT " + str(slot_num) + " CLICKED")
	var combinator_resource_type = resource_combinator[slot_num]
	print("COMBINATOR RESOURCE TYPE: " + str(combinator_resource_type))
	if resource_carried == ResourceType.NONE:
		set_combinator_resource_to(slot_num, ResourceType.NONE)
		set_carried_resource_to(combinator_resource_type)
	elif combinator_resource_type == ResourceType.NONE:
		set_combinator_resource_to(slot_num, resource_carried)
		set_carried_resource_to(ResourceType.NONE)

func set_combinator_resource_to(slot_num, resource_type): 
	resource_combinator[slot_num] = resource_type
	$Workroom.set_combinator_slot_to_item(slot_num, resource_type)
	
func set_carried_resource_to(resource_type): 
	resource_carried = resource_type
	$ResourceDrag.change_resource(resource_type)

func _on_Workroom_click_on_combinator_output():
	print("GAME CONTROLLER CLICK ON COMBINATOR OUTPUT")
	if resource_combinator == NOTHING:
		return
	var recipe_output = recipes.recipe_for(resource_combinator)
	for slot_num in range(0,3,1):
		set_combinator_resource_to(slot_num, ResourceType.NONE)
	set_carried_resource_to(recipe_output)
	
func _on_BookArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("open_book")
	
func _on_CauldronArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		on_cauldron_click()

func on_cauldron_click(): 
	if resource_carried != ResourceType.NONE and cauldron_contents == ResourceType.NONE:
		print("ADDING TO CAULDRON")
		var cauldron_set = $CauldronSet
		cauldron_set.add_ingredient_to_cauldron()
		cauldron_contents = resource_carried
		set_carried_resource_to(ResourceType.NONE)
	elif resource_carried == ResourceType.NONE and cauldron_contents != ResourceType.NONE:
		print("REMOVING FROM CAULDRON")
		var cauldron_set = $CauldronSet
		cauldron_set.empty_cauldron()
		set_carried_resource_to(cauldron_contents)
		cauldron_contents = ResourceType.NONE
		
