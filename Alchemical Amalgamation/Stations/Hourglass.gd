extends Node2D

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$AnimatedSprite.play("sand")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.get_animation() == "sand": 
		$AnimatedSprite.play("done")
