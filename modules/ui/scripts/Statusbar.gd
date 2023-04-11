extends Control

var displayedHealth: int = 100
var displayedSugar: int = 100

onready var healthCircle = $HealthCircle
onready var healthBar = $HealthBar
onready var sugarBar = $SugarBar

func _process(delta):
	if displayedSugar == 100:
		sugarBar.material.set_shader_param("strength", 0.5)
	else:
		sugarBar.material.set_shader_param("strength", 0.0)

func update():
	healthCircle.value = displayedHealth
	healthBar.value = displayedHealth
	sugarBar.value = displayedSugar
