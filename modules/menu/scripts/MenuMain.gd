extends Node2D

# Buttons
onready var buttonStart = $UI/VBoxContainer/ButtonStart

func _ready():
	buttonStart.grab_focus()

func _on_ButtonStart_pressed():
	get_tree().change_scene("res://modules/stages/Stage1.tscn")

func _on_ButtonSelect_pressed():
	#get_tree().change_scene("")
	pass

func _on_ButtonOptions_pressed():
	#get_tree().change_scene("")
	pass

func _on_ButtonExit_pressed():
	get_tree().quit()
