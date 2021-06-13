extends Node2D

signal sell_potion_to(customer_number)

func _on_Customer_click_on_customer(number):
	emit_signal("sell_potion_to", number)

func create_customer_with_message(customer_number, message): 
	match customer_number:
		0: $Customer0.set_customer_message(message)
		1: $Customer1.set_customer_message(message)
		2: $Customer2.set_customer_message(message)
		3: $Customer3.set_customer_message(message)
		4: $Customer4.set_customer_message(message)
								
func remove_customer(customer_number): 
	match customer_number:
		0: $Customer0.remove_customer()
		1: $Customer1.remove_customer()
		2: $Customer2.remove_customer()
		3: $Customer3.remove_customer()
		4: $Customer4.remove_customer()
