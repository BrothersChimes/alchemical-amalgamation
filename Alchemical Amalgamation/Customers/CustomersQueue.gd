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
	
var customers = [
	create_customer("Water, please!", ResourceType.WATER),
	create_customer("Some pure awesome!", ResourceType.AWESOME),
	create_customer("I want an Etter Cap!", ResourceType.ETTERCAP),
	create_customer("Awesome!", ResourceType.AWESOME),
	create_customer("Gimme that mermaid horn!", ResourceType.MERMAID),
	create_customer("I'm thirsty for water!", ResourceType.WATER),
	create_customer("I need mermaid horn!", ResourceType.MERMAID),
	create_customer("Gimme Etter Cap!!!", ResourceType.ETTERCAP),
]

func customers():
	return customers
