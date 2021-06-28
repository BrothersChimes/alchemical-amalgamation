extends Node2D

func _ready():
	pass # Replace with function body.

func music_on(): 
	$MusicOn.visible = true
	$MusicOff.visible = false
	
func music_off(): 
	$MusicOn.visible = false
	$MusicOff.visible = true
