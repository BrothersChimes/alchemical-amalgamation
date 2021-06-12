extends Node2D

signal sell_potion_to(customer)

func _on_Customer_sell_potion_to(customer):
	emit_signal("sell_potion_to", customer)
