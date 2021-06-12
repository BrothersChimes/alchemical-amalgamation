extends Node2D

signal sell_potion

func _on_Customer_sell_potion():
	emit_signal("sell_potion")
