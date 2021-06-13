extends Node2D

signal open_book


const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

const CombinatorRecipes = preload("res://Stations/CombinatorRecipe.gd")
var combinator_recipes = CombinatorRecipes.new()


var NOTHING = [ResourceType.NONE, ResourceType.NONE, ResourceType.NONE]
var resource_carried = ResourceType.NONE
var resource_combinator= [ResourceType.NONE, ResourceType.NONE, ResourceType.NONE]

var CustomersQueue = preload("res://Customers/CustomersQueue.gd")
var customersQueue = CustomersQueue.new()

var gold = 1000
var rep = 0

var customer_desired_resources = [
	ResourceType.NONE, ResourceType.NONE, ResourceType.NONE,
	ResourceType.NONE, ResourceType.NONE
]

func _ready():
	set_start_customer()
	$Gold.set_gold(gold)
	$Reputation.set_reputation(rep)
	
func add_gold(extra_gold): 
	gold += extra_gold
	$Gold.set_gold(gold)
	
func add_reputation(extra_reputation): 
	rep += extra_reputation
	$Reputation.set_reputation(rep)
	
func _process(delta): 
	cauldron_process(delta)

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
		$SuccessAndFailureText.set_text_success()
		add_gold(100)
		add_reputation(1)
	else:
		$SuccessAndFailureText.set_text_failure()
		add_gold(-100)
		add_reputation(-1)
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
	var combinator_resource_type = resource_combinator[slot_num]
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
	if resource_combinator == NOTHING:
		return
	var recipe_output = combinator_recipes.recipe_for(resource_combinator)
	for slot_num in range(0,3,1):
		set_combinator_resource_to(slot_num, ResourceType.NONE)
	set_carried_resource_to(recipe_output)
	
func _on_BookArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("open_book")
	
const CauldronRecipes = preload("res://Stations/CauldronRecipe.gd")
var cauldron_recipes = CauldronRecipes.new()

var cauldron_contents = ResourceType.NONE

enum Heat {
	DEAD,
	LOW,
	MED,
	HIGH,
	BLAZE,
	ANY
}
const CAULDRON_BURN_TIME = 5
const CAULDRON_WRONG_TEMP_ALLOWED_TIME = 5
var cauldron_max_time = 2
var cauldron_timer = 0
var wrong_temp_time = 0
var is_cauldron_boiling = false
var is_potion_done = false
var is_potion_ruined = false
var preferred_cauldron_temp_low = Heat.ANY
var preferred_cauldron_temp_high = Heat.ANY
var cauldron_recipe = null

func cauldron_process(delta): 
	if is_cauldron_boiling and cauldron_recipe != null: 
		cauldron_timer += delta
		var cauldron_temp = $CauldronSet.get_heat_level_cauldron()
		if cauldron_temp < cauldron_recipe.MinHeat or cauldron_temp > cauldron_recipe.MaxHeat:
			wrong_temp_time += delta
		if cauldron_timer >= cauldron_recipe.BoilTime:
			if not is_potion_done:
				cauldron_potion_done()
			wrong_temp_time += delta
		if wrong_temp_time >= CAULDRON_WRONG_TEMP_ALLOWED_TIME: 
			print("Potion ruined due to wrong temperature")
			is_potion_ruined = true
			
	
func _on_CauldronArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		on_cauldron_click()

func on_cauldron_click(): 
	if resource_carried != ResourceType.NONE and cauldron_contents == ResourceType.NONE:
		start_boiling_cauldron(resource_carried)
		set_carried_resource_to(ResourceType.NONE)
	elif resource_carried == ResourceType.NONE and cauldron_contents != ResourceType.NONE:
		get_cauldron_contents()
		
func start_boiling_cauldron(ingredient): 
	print("Start boiling")
	is_potion_done = false
	is_potion_ruined = false
	is_cauldron_boiling = true
	cauldron_timer = 0
	wrong_temp_time = 0
	$CauldronSet.add_ingredient_to_cauldron()
	cauldron_contents = ingredient
	cauldron_recipe = cauldron_recipes.recipe_for(ingredient)
	
func get_cauldron_contents(): 
	if not is_potion_done:
		print("Potion not done")
	if not is_potion_ruined:
		print("Potion ruined")
	if not is_potion_done or is_potion_ruined: 

		set_carried_resource_to(ResourceType.CRAP)
	else:
		var good_contents = cauldron_recipe.Output
		print("GOOD CONTENTS: " + str(good_contents))
		set_carried_resource_to(good_contents) # TODO
	empty_out_cauldron()
	
func empty_out_cauldron(): 
	is_potion_done = false
	is_potion_ruined = false
	is_cauldron_boiling = false
	$CauldronSet.empty_cauldron()
	cauldron_contents = ResourceType.NONE

func cauldron_potion_done():
	is_potion_done = true
	$CauldronSet.finish_cauldron()
