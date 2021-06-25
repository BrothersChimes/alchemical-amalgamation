extends Node

const ResourceTypeFile = preload("res://Resources/ResourceType.gd")
var ResourceType = ResourceTypeFile.ResourceType

class Customer:
	var Message: String
	var Desire: int # actually an enum

func create_customer(message, desire): 
	var customer = Customer.new()
	customer.Message = message
	customer.Desire = desire
	return customer
	
var customers_day_0 = [
	create_customer("Water, please!", ResourceType.WATER),
	create_customer("Some pure awesome!", ResourceType.AWESOME),
	create_customer("I want an Etter Cap!", ResourceType.ETTERCAP),
	create_customer("I require Liquid Awesome!", ResourceType.LIQUID_AWESOME),
	create_customer("Gimme that mermaid horn!", ResourceType.MERMAID),
	create_customer("Pure Awesome!", ResourceType.AWESOME),
	create_customer("Riddle me this...", ResourceType.RIDDLER),
]
	
var customers_final_days = [
	create_customer("Give me Burner's Hair", ResourceType.BURNERS_HAIR),
	create_customer("I require a flaming blossom", ResourceType.FLAMING_BLOSSOM),
	create_customer("Iron Spice!", ResourceType.IRON_SPICE),
	create_customer("Water, please!", ResourceType.WATER),
	create_customer("Some pure awesome!", ResourceType.AWESOME),
	create_customer("I want an Etter Cap!", ResourceType.ETTERCAP),
	create_customer("I require Liquid Awesome!", ResourceType.LIQUID_AWESOME),
	create_customer("Gimme that mermaid horn!", ResourceType.MERMAID),
	create_customer("Boiled Mermaid Horn", ResourceType.BOILED_MERMAID),
	create_customer("I'm thirsty for water!", ResourceType.WATER),
	create_customer("I need mermaid horn!", ResourceType.MERMAID),
	create_customer("Gimme Etter Cap!!!", ResourceType.ETTERCAP),
	create_customer("I love mermaids", ResourceType.MERMAID),
	create_customer("Give me Burner's Hair", ResourceType.BURNERS_HAIR),
	create_customer("Pure Awesome!", ResourceType.AWESOME),
	create_customer("Riddle me this...", ResourceType.RIDDLER),
	create_customer("I require a flaming blossom", ResourceType.FLAMING_BLOSSOM),
	create_customer("I want Maid's Cap", ResourceType.MAIDS_CAP),
	create_customer("I require a part of a behemoth", ResourceType.BEHEMOTH),
	create_customer("LIQUID_AWESOME", ResourceType.LIQUID_AWESOME),
	create_customer("Iron Spice!", ResourceType.IRON_SPICE),
	create_customer("Burner's Hair", ResourceType.BURNERS_HAIR),
	create_customer("Cap o' th' Maid", ResourceType.MAIDS_CAP),
	create_customer("Boiled Mermaid Horn", ResourceType.BOILED_MERMAID),
	create_customer("Maid's Cap, please!", ResourceType.MAIDS_CAP),
	create_customer("Etter's Cap, please!", ResourceType.ETTERCAP),
	create_customer("Require Iron Spice!", ResourceType.IRON_SPICE),
	create_customer("I need mermaid horn!", ResourceType.MERMAID),
	create_customer("Gimme Etter Cap!!!", ResourceType.ETTERCAP),
	create_customer("I love mermaids", ResourceType.MERMAID),
	create_customer("Give me Burner's Hair", ResourceType.BURNERS_HAIR),
	create_customer("Pure Awesome!", ResourceType.AWESOME),
	create_customer("Riddle me this...", ResourceType.RIDDLER),
	create_customer("I require a flaming blossom", ResourceType.FLAMING_BLOSSOM),
	create_customer("I want Maid's Cap", ResourceType.MAIDS_CAP),
	create_customer("I require a part of a behemoth", ResourceType.BEHEMOTH),
	create_customer("LIQUID_AWESOME", ResourceType.LIQUID_AWESOME),
	create_customer("Iron Spice!", ResourceType.IRON_SPICE),
	create_customer("Burner's Hair", ResourceType.BURNERS_HAIR),
	create_customer("Cap o' th' Maid", ResourceType.MAIDS_CAP),
	create_customer("Boiled Mermaid Horn", ResourceType.BOILED_MERMAID),
	create_customer("Maid's Cap, please!", ResourceType.MAIDS_CAP),
	create_customer("Etter's Cap, please!", ResourceType.ETTERCAP),
	create_customer("Require Iron Spice!", ResourceType.IRON_SPICE),
	create_customer("LIQUID_AWESOME", ResourceType.LIQUID_AWESOME),
	create_customer("Iron Spice!", ResourceType.IRON_SPICE),
	create_customer("Burner's Hair", ResourceType.BURNERS_HAIR),
	create_customer("Cap o' th' Maid", ResourceType.MAIDS_CAP),
	create_customer("Boiled Mermaid Horn", ResourceType.BOILED_MERMAID),
	create_customer("Maid's Cap, please!", ResourceType.MAIDS_CAP),
	create_customer("Etter's Cap, please!", ResourceType.ETTERCAP),
	create_customer("Require Iron Spice!", ResourceType.IRON_SPICE),
	create_customer("I need mermaid horn!", ResourceType.MERMAID),
	create_customer("Gimme Etter Cap!!!", ResourceType.ETTERCAP),
	create_customer("I love mermaids", ResourceType.MERMAID),
	create_customer("Give me Burner's Hair", ResourceType.BURNERS_HAIR),
	create_customer("Pure Awesome!", ResourceType.AWESOME),
	create_customer("Riddle me this...", ResourceType.RIDDLER),
	create_customer("I require a flaming blossom", ResourceType.FLAMING_BLOSSOM),
	create_customer("I want Maid's Cap", ResourceType.MAIDS_CAP),
	create_customer("I require a part of a behemoth", ResourceType.BEHEMOTH),
	create_customer("LIQUID_AWESOME", ResourceType.LIQUID_AWESOME),
	create_customer("Iron Spice!", ResourceType.IRON_SPICE),
	]

# NOTE: does not duplicate the arrays!
func customers_for_day(day):
	if day == 0: 
		return customers_day_0
	else: 
		return customers_final_days
