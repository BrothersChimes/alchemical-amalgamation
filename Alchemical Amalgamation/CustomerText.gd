extends Node2D

signal sell_potion_to(customer_number)

func _on_Customer_click_on_customer(number):
	emit_signal("sell_potion_to", number)

func create_customer_with_message_and_item(customer_number, message, item_type): 
	match customer_number:
		0: $Customer0.set_customer_message_and_item(message,item_type)
		1: $Customer1.set_customer_message_and_item(message,item_type)
		2: $Customer2.set_customer_message_and_item(message,item_type)
		3: $Customer3.set_customer_message_and_item(message,item_type)
		4: $Customer4.set_customer_message_and_item(message,item_type)
								
func remove_customer(customer_number): 
	match customer_number:
		0: $Customer0.remove_customer()
		1: $Customer1.remove_customer()
		2: $Customer2.remove_customer()
		3: $Customer3.remove_customer()
		4: $Customer4.remove_customer()
