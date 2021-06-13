extends Node2D


func set_gold(new_gold): 
	$RichTextLabel.text = str(new_gold) + " gp"
