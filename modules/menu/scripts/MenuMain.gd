extends Node2D

# Buttons
onready var buttonStart = $UI/VBoxContainer/ButtonStart

func _ready():
	buttonStart.grab_focus()

func switch_scene(next_scene_path):
	var scene_container = get_tree().get_root().get_node("Game/ViewportContainer/Viewport")

	# Clear everything under Viewport
	for i in range(scene_container.get_child_count()):
		var child = scene_container.get_child(i)
		child.queue_free()

	# Load level under viewport
	var next_level_res = load(next_scene_path)
	var next_level = next_level_res.instance()
	scene_container.add_child(next_level)

func _on_ButtonStart_pressed():
	switch_scene("res://modules/stages/Stage1.tscn")

func _on_ButtonSelect_pressed():
	#get_tree().change_scene("")
	pass

func _on_ButtonOptions_pressed():
	#get_tree().change_scene("")
	pass

func _on_ButtonExit_pressed():
	get_tree().quit()
