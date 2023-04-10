extends Control

var displayedHealth: int = 100

onready var healthCircle = $HealthCircle
onready var healthBar = $HealthBar

func update():
	healthCircle.value = displayedHealth
	healthBar.value = displayedHealth
