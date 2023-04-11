extends Node2D

# Buttons
onready var buttonStart = $UI/VBoxContainer/ButtonStart
onready var buttonSelect = $UI/VBoxContainer/ButtonSelect
onready var buttonOptions = $UI/VBoxContainer/ButtonOptions
onready var buttonExit = $UI/VBoxContainer/ButtonExit

# Cursors
var offsetLeft = Vector2(-12, 4)
var offsetRight = Vector2(4, 4)
onready var cursorLeft = $UI/CursorLeft
onready var cursorRight = $UI/CursorRight

func _ready():
	buttonStart.add_font_override("font", Autorun.yellowBlackFont)
	buttonSelect.add_font_override("font", Autorun.yellowBlackFont)
	buttonOptions.add_font_override("font", Autorun.yellowBlackFont)
	buttonExit.add_font_override("font", Autorun.yellowBlackFont)
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

func _on_ButtonStart_focus_entered():
	cursorLeft.rect_global_position = buttonStart.rect_global_position + offsetLeft
	cursorRight.rect_global_position = buttonStart.rect_global_position + Vector2(8 * buttonStart.text.length(), 0) + offsetRight

func _on_ButtonSelect_focus_entered():
	cursorLeft.rect_global_position = buttonSelect.rect_global_position + offsetLeft
	cursorRight.rect_global_position = buttonSelect.rect_global_position + Vector2(8 * buttonSelect.text.length(), 0) + offsetRight

func _on_ButtonOptions_focus_entered():
	cursorLeft.rect_global_position = buttonOptions.rect_global_position + offsetLeft
	cursorRight.rect_global_position = buttonOptions.rect_global_position + Vector2(8 * buttonOptions.text.length(), 0) + offsetRight

func _on_ButtonExit_focus_entered():
	cursorLeft.rect_global_position = buttonExit.rect_global_position + offsetLeft
	cursorRight.rect_global_position = buttonExit.rect_global_position + Vector2(8 * buttonExit.text.length(), 0) + offsetRight
