extends Control

var displayedHealth: int = 100
var displayedSugar: int = 100

onready var healthCircle = $HealthCircle
onready var healthBar = $HealthBar
onready var sugarBar = $SugarBar
onready var lives = $Lives

func _ready():
	lives.add_font_override("font", Autorun.whiteGreenFont)

func _process(_delta):
	if displayedSugar == 100:
		sugarBar.material.set_shader_param("strength", 0.5)
	else:
		sugarBar.material.set_shader_param("strength", 0.0)

func set_health(num: int):
	displayedHealth = num
	update()

func set_sugar(num: int):
	displayedSugar = num
	update()

func update():
	healthCircle.value = displayedHealth
	healthBar.value = displayedHealth
	sugarBar.value = displayedSugar
