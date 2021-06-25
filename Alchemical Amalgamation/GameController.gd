extends Node2D

signal open_book
signal end_day

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

const CombinatorRecipes = preload("res://Stations/CombinatorRecipe.gd")
var combinator_recipes = CombinatorRecipes.new()
var combinator_output = ResourceType.NONE

var NOTHING = [ResourceType.NONE, ResourceType.NONE, ResourceType.NONE]
var resource_carried = ResourceType.NONE
var resource_combinator= [ResourceType.NONE, ResourceType.NONE, ResourceType.NONE]

var CustomersQueue = preload("res://Customers/CustomersQueue.gd")
var customersQueue = CustomersQueue.new()
onready var cauldron_set = get_node("CauldronSet")
var has_cauldron_set = false

var day = 0
var gold = 1000
var rep = 0

const DAY_LENGTH = 60
var day_timer = 0
var day_first_third = DAY_LENGTH / 3
var day_second_third = day_first_third*2

var customer_desired_resources = [
	ResourceType.NONE, ResourceType.NONE, ResourceType.NONE,
	ResourceType.NONE, ResourceType.NONE
]

func _ready():
	$Gold.set_gold(gold)
	$Reputation.set_reputation(rep)
	setup_for_day(0)

func _process(delta): 
	cauldron_process(delta)
	if Input.is_action_just_pressed("drop_potion"):
		drop_potion_event()
	day_process(delta)

func day_process(delta): 
	### TODO Debug - remove
	if Input.is_action_just_pressed("end_day"):
		print("Day ended.")
		emit_signal("end_day")
		restart_day()
	###
	day_timer += delta
	if day_timer >= DAY_LENGTH:
		print("Day ended.")
		emit_signal("end_day")
		restart_day()
	elif day_timer >= day_second_third:
		# print("second third reached")
		$Clock/AnimatedSprite.frame = 2
	elif day_timer >= day_first_third:
		# print("First third reached")
		$Clock/AnimatedSprite.frame = 1	

func restart_day(): 
	day_timer = 0
	$Clock/AnimatedSprite.frame = 0

func setup_for_day(day_num): 
	day = day_num
	$Workroom.setup_for_day(day_num)
	customersQueue.setup_for_day(day_num)
	if day_num == 0: 
		setup_for_day_0()
	elif day_num == 1: 
		setup_for_day_1()
	elif day_num == 2: 
		setup_for_day_2()
	else: 
		setup_for_final_days()
	restart_day()
	set_start_customer()

func setup_for_day_0(): 
	has_cauldron_set = false
	remove_child(cauldron_set)
	$WoodArea.visible = false
	$CoalArea.visible = false
	$ShovelArea.visible = false
	$CombinatorOutArea.visible = false

func setup_for_day_1(): 
	$CombinatorOutArea.visible = true

func setup_for_day_2(): 
	has_cauldron_set = true
	add_child(cauldron_set)
	$WoodArea.visible = true
	$CoalArea.visible = true
	$ShovelArea.visible = true

func setup_for_final_days(): 
	pass

func add_gold(extra_gold): 
	gold += extra_gold
	$Gold.set_gold(gold)
	
func add_reputation(extra_reputation): 
	rep += extra_reputation
	$Reputation.set_reputation(rep)

func set_start_customer(): 
	customer_desired_resources = [
		ResourceType.NONE, ResourceType.NONE, ResourceType.NONE,
		ResourceType.NONE, ResourceType.NONE
	]
	set_customers()

func set_customers(): 
	#NOTE: Does not duplicate the array - changes here are changes there
	# var queue = customersQueue.customers_for_day(day)
	
	for i in range(0, customer_desired_resources.size()):
#		if queue.empty():
#			return
		var customer = customer_desired_resources[i]
		if customer != ResourceType.NONE:
			continue
		var next_customer = customersQueue.get_next_customer()
		customer_desired_resources[i] = next_customer.Desire
		$CustomerText.create_customer_with_message_and_item(i, next_customer.Message, next_customer.Desire)

func drop_potion_event(): 
	if resource_carried == ResourceType.NONE:
		return
	elif resource_carried == ResourceType.CRAP:
		destroy_carried_resource()
	elif ResourceTypeFile.is_resource_raw(resource_carried):
		$Workroom/PurchaseSound.play()
		add_gold(ResourceTypeFile.buy_price_for(resource_carried))
		set_carried_resource_to(ResourceType.NONE)
	else: 
		var could_place = $Workroom.place_resource_on_first_open_holder(resource_carried)
		if could_place: 
			set_carried_resource_to(ResourceType.NONE)
			$Workroom/PickUpPotionSound.play()

func _on_Workroom_drag_resource_from_shelf(resource_type):
	if resource_carried == ResourceType.NONE:
		set_carried_resource_to(resource_type)
		add_gold(-ResourceTypeFile.buy_price_for(resource_type))
		$Workroom/PurchaseSound.play()
	elif ResourceTypeFile.is_resource_raw(resource_carried):
		if resource_carried == resource_type:
			set_carried_resource_to(ResourceType.NONE)
			add_gold(ResourceTypeFile.buy_price_for(resource_type))
			$Workroom/PurchaseSound.play()
		else:
			add_gold(ResourceTypeFile.buy_price_for(resource_carried))
			add_gold(-ResourceTypeFile.buy_price_for(resource_type))
			set_carried_resource_to(resource_type)
			$Workroom/DropPotionSound.play()
	
func _on_Workroom_destroy_resource():
	destroy_carried_resource()

func destroy_carried_resource(): 
	if resource_carried != ResourceType.NONE:
		$Workroom/BinSound.play()
	set_carried_resource_to(ResourceType.NONE)

func _on_Workroom_drop_resource():
	set_carried_resource_to(ResourceType.NONE)
	
func _on_CustomerText_sell_potion_to(customer_number):
	if resource_carried == ResourceType.NONE:
		return
	if resource_carried == customer_desired_resources[customer_number]:
		var sale_price = ResourceTypeFile.sale_price_for(resource_carried)
		$SuccessAndFailureText.set_text_success(sale_price, 1)
		add_gold(sale_price)
		add_reputation(1)
	else:
		var sale_price = ResourceTypeFile.sale_price_for(resource_carried)
		$SuccessAndFailureText.set_text_failure(sale_price, 5)
		add_gold(-sale_price*2)
		add_reputation(-5)
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
		if combinator_resource_type != ResourceType.NONE:
			$Workroom/DropPotionSound.play()
		set_combinator_resource_to(slot_num, ResourceType.NONE)
		set_carried_resource_to(combinator_resource_type)
	elif combinator_resource_type == ResourceType.NONE:
		if resource_carried != ResourceType.NONE: 
			$Workroom/DropPotionSound.play()
		set_combinator_resource_to(slot_num, resource_carried)
		set_carried_resource_to(ResourceType.NONE)

func set_combinator_resource_to(slot_num, resource_type): 
	resource_combinator[slot_num] = resource_type
	var recipe_output = combinator_recipes.recipe_for(resource_combinator)
	combinator_output = recipe_output
	$Workroom.set_combinator_slot_to_item(slot_num, resource_type, recipe_output)
	
func set_carried_resource_to(resource_type): 
	resource_carried = resource_type
	$ResourceDrag.change_resource(resource_type)

func _on_Workroom_click_on_combinator_output():
	if resource_combinator == NOTHING or resource_carried != ResourceType.NONE:
		return
	$Workroom/PickUpPotionSound.play()
	var recipe_output = combinator_recipes.recipe_for(resource_combinator)
	for slot_num in range(0,3,1):
		set_combinator_resource_to(slot_num, ResourceType.NONE)
	set_carried_resource_to(recipe_output)
	
func _on_BookArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
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
var overboil_time = 0
var is_cauldron_boiling = false
var is_potion_done = false
var is_potion_ruined = false
var preferred_cauldron_temp_low = Heat.ANY
var preferred_cauldron_temp_high = Heat.ANY
var cauldron_recipe = null

enum PotionDisplayState  {
	FINE, OVERCOOKED, COLD, HOT, BAD_TEMP, BAD
}

var potion_display_state = PotionDisplayState.FINE

func cauldron_process(delta):
	if not has_cauldron_set: 
		return
	if is_cauldron_boiling and cauldron_recipe != null: 
		potion_display_state = PotionDisplayState.FINE
		cauldron_timer += delta
		var cauldron_temp = $CauldronSet.get_heat_level_cauldron()
		if cauldron_temp < cauldron_recipe.MinHeat:
			potion_display_state = PotionDisplayState.COLD
			wrong_temp_time += delta
		elif cauldron_temp > cauldron_recipe.MaxHeat:
			potion_display_state = PotionDisplayState.HOT
			wrong_temp_time += delta
		if cauldron_timer >= cauldron_recipe.BoilTime:
			if not is_potion_done:
				cauldron_potion_done()
			overboil_time += delta
		if wrong_temp_time >= CAULDRON_WRONG_TEMP_ALLOWED_TIME: 
			potion_display_state = PotionDisplayState.BAD_TEMP
			is_potion_ruined = true
			cauldron_potion_ruined()
		elif overboil_time >= CAULDRON_WRONG_TEMP_ALLOWED_TIME:
			potion_display_state = PotionDisplayState.OVERCOOKED
			is_potion_ruined = true
			cauldron_potion_ruined()
	set_cauldron_status_label()
			
func set_cauldron_status_label(): 
	var status = $CauldronSet/CauldronStatusLabel
	status.visible = potion_display_state != PotionDisplayState.FINE and cauldron_contents != ResourceType.NONE
	#status.visible = true
	match(potion_display_state):
		PotionDisplayState.OVERCOOKED: 
			status.text = "Boiled too long"
		PotionDisplayState.COLD: 
			status.text = "Fire too cold"	
		PotionDisplayState.HOT: 
			status.text = "Fire too hot"
		PotionDisplayState.BAD_TEMP: 
			status.text = "Bad temp too long"
		PotionDisplayState.BAD:
			status.text = "Bad recipe"

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
	if cauldron_recipe.Output == ResourceType.CRAP:
		potion_display_state = PotionDisplayState.BAD
		cauldron_potion_ruined()
		
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
	overboil_time = 0
	$CauldronSet.empty_cauldron()
	cauldron_contents = ResourceType.NONE

func cauldron_potion_ruined(): 
	is_potion_done = true
	is_potion_ruined = true
	is_cauldron_boiling = false
	$CauldronSet.ruin_cauldron()

func cauldron_potion_done():
	is_potion_done = true
	if is_potion_ruined: 
		$CauldronSet.ruin_cauldron()
	else: 
		$CauldronSet.finish_cauldron()
		
func _on_CauldronArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		on_cauldron_click()
		
func _on_BellowsArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$CauldronSet.bellows_pressed_event()

func _on_WoodArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$CauldronSet.wood_add_event()

func _on_CoalArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$CauldronSet.coal_add_event()
		
func _on_ShovelArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$CauldronSet.shovel_embers_event()

func _on_CombinatorOutArea_area_entered(area):
	var text_area = $CombinatorOutArea/CombinatorAltText
	if area.name == "HoverHackArea":
		if combinator_output != ResourceType.NONE:
			text_area.text = ResourceTypeFile.display_name(combinator_output)
			text_area.visible = true

			
func _on_CombinatorOutArea_area_exited(area):
	if area.name == "HoverHackArea":
		$CombinatorOutArea/CombinatorAltText.visible = false

func _on_Workroom_click_on_holding_resource(resource, number):
	var was_carried = resource_carried
	set_carried_resource_to(resource)
	$Workroom.set_holder_to(was_carried, number)
	$Workroom/PickUpPotionSound.play()
