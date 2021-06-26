extends Node

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

var day

class Customer:
	var Message: String
	var Desire: int # actually an enum

func create_customer(message, desire): 
	var customer = Customer.new()
	customer.Message = message
	customer.Desire = desire
	return customer

func setup_for_day(day_num):
	day = day_num

#TODO 
func which_day():
	var max_day = customers.size() - 1
	if day > max_day:
		return randi()%customers.size()
	
	var my_day = min(day, max_day)
	if my_day == 0: 
		return 0
	if my_day == 1: 
		var rand_val = randi()%3
		if rand_val == 0: 
			return 0
		return 1
		
	var rand_list = []
	for x in range(0, my_day-1): 
		rand_list.append(x)
	rand_list.append(my_day - 1)
	rand_list.append(my_day - 1)
	rand_list.append(my_day)
	rand_list.append(my_day)
	rand_list.append(my_day)
	rand_list.append(my_day)
	var which_point = randi()%rand_list.size()
	return rand_list[which_point] 

var customers_day_0 = [
	create_customer("Water, please!", ResourceType.WATER),
	create_customer("I want an Etter Cap!", ResourceType.ETTERCAP),
]

var customers_day_1 = [
	create_customer("Gimme that mermaid horn!", ResourceType.MERMAID),
	create_customer("Some pure awesome!", ResourceType.AWESOME),
	create_customer("LIQUID AWESOME", ResourceType.LIQUID_AWESOME),
	create_customer("I want Maid's Cap", ResourceType.MAIDS_CAP),
]
	
var customers_day_2 = [
	create_customer("Just a blossom, please", ResourceType.BLOSSOM),
	create_customer("Riddle me this...", ResourceType.RIDDLER),
	create_customer("I require a FLAMING blossom!", ResourceType.FLAMING_BLOSSOM),
	create_customer("Give me Burner's Hair", ResourceType.BURNERS_HAIR),
	create_customer("Boiled Mermaid Horn", ResourceType.BOILED_MERMAID),
]

var customers_day_3 = [
	create_customer("I need a Behemoth part", ResourceType.BEHEMOTH),
	create_customer("Some mysterious ectoplasm", ResourceType.ECTOPLASM),
	create_customer("Iron Spice!", ResourceType.IRON_SPICE),
	create_customer("I need fang shards", ResourceType.FANG_SHARD),
	create_customer("Behemoth Dust", ResourceType.BEHEMOTH_DUST),
	create_customer("Powder for vengeance!", ResourceType.VENGEANCE_POWDER),
]
	
var customers_day_4 = [
	create_customer("What is brain bark?", ResourceType.BRAINBARK),
	create_customer("MMmmmm... honey!", ResourceType.HONEY),
	create_customer("Ecto... plasma", ResourceType.ECTO_PLASMA),	
]

var customers_day_5 = [
	create_customer("Dragon Sauce.", ResourceType.DRAGON_SAUCE),
	create_customer("Concentrated Dragon Sauce.", ResourceType.CONCENTRATED_HOT_SAUCE),
	create_customer("STUN. BRICK.", ResourceType.STUNBRICK),
]

var customers =  [
		customers_day_0,
		customers_day_1,
		customers_day_2,
		customers_day_3,
		customers_day_4,
		customers_day_5,
	]

func get_next_customer(): 
	var which_day = which_day()
	var customer_array = customers[which_day]
	var element = randi()%customer_array.size()
	var customer = customer_array[element]
	return customer
