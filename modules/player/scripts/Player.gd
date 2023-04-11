extends KinematicBody2D

# - Movement -
# Constants
const GRAVITY: int = 800
const ACCEL:int = 600
const FRIC:int = 20
const MAXSPD:int = 180
const JUMPSPD:int = 320

# Variables
var gravity: int = GRAVITY
var speed: float = 0
var direction: int = 1
var canJump: bool = true
var jumpPressed: bool = false
var passThrough:bool = false
var motion := Vector2.ZERO
var normal := Vector2.UP
var snap := Vector2.ZERO

# - Animation -
enum{
	IDLE,
	RUN,
	JUMP,
	FALL,
	ATTACK,
	SPECIAL1,
	SPECIAL2,
	SPECIAL3,
}
var animation = IDLE

# Nodes
onready var sprite = $Sprite
onready var camera = $Camera

# - Action -
# Variables
var inputHistory: Array = []

# Nodes
onready var inputTimer = $InputTimer

# - Functions -
func _ready():
	var tilemapRect = get_parent().get_node("Geometry").get_used_rect()
	var tilemapCellSize = get_parent().get_node("Geometry").cell_size
	camera.limit_left = (tilemapRect.position.x) * tilemapCellSize.x
	camera.limit_right = (tilemapRect.end.x) * tilemapCellSize.x
	camera.limit_bottom = (tilemapRect.end.y) * tilemapCellSize.y
	sprite.play("Idle")

func _input(_event):
	if Input.is_action_just_pressed("Left"):
		log_input("Left")
	if Input.is_action_just_pressed("Right"):
		log_input("Right")
	if Input.is_action_just_pressed("Up"):
		log_input("Up")
	if Input.is_action_just_pressed("Down"):
		log_input("Down")
	if Input.is_action_just_pressed("Jump"):
		log_input("Jump")
	if Input.is_action_just_pressed("Attack"):
		log_input("Attack")

func _process(delta):
	if direction == 1:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	$UI/Control/Label.text = str(jumpPressed) + "\n" + str(motion.y)
	animate()

func _physics_process(delta):
	# Apply movement according to input
	if get_input().x == 0:
		apply_friction(delta)
		if is_on_floor():
			animation = IDLE
	else:
		direction = get_input().x
		apply_acceleration(get_input().x, delta)
		if is_on_floor():
			animation = RUN

	if Input.is_action_just_pressed("Attack"):
		attack()

	if Input.is_action_pressed("Up"):
		camera.offset.y = lerp(camera.offset.y, -50, delta * 2)
	elif Input.is_action_pressed("Down"):
		camera.offset.y = lerp(camera.offset.y, 50, delta * 2)
	else:
		camera.offset.y = lerp(camera.offset.y, 0, delta * 2)

	passThrough = Input.is_action_pressed("Down")

	if is_on_floor():
		canJump = true
		motion.y = 0
		snap = Vector2.DOWN * 6
		if jumpPressed:
			if passThrough:
				position.y += 1
			else:
				motion.y = 0
				animation = JUMP
				snap = Vector2.ZERO
				motion.y -= JUMPSPD
	else:
		coyote_time()
		if get_input().y == 0 and motion.y < -JUMPSPD * .5:
			motion.y = -JUMPSPD * .5
	
	if Input.is_action_just_pressed("Jump"):
		jumpPressed = true
		jump_buffer()
		if canJump:
			if passThrough:
				if get_floor_normal() == Vector2.UP:
					position.y += 1
			else:
				motion.y = -JUMPSPD

	apply_gravity(delta)

	motion = move_and_slide_with_snap(motion, snap, Vector2.UP, true)

# Returns a vector with the strength of the input
func get_input():
	# Store Input
	var input = Vector2.ZERO

	# 1 if Right, -1 if Left, 0 if either or none
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	# 1 if pressing Jump
	input.y = Input.get_action_strength("Jump")

	return input

func apply_gravity(delta):
	motion.y += gravity * delta

func apply_friction(delta):
	motion.x = lerp(motion.x, 0, FRIC * delta)

func apply_acceleration(dir, delta):
	motion.x += dir * ACCEL * delta
	motion.x = clamp(motion.x, -MAXSPD, MAXSPD)

func attack():
	match inputHistory:
		["Attack", "Attack", "Attack"]:
			print("Jab + One Two")
			inputHistory.clear()
		["Attack", "Left", "Attack"], ["Attack", "Right", "Attack"]:
			print("Jab + Hook")
			inputHistory.clear()
		["Left", "Left", "Attack"], ["Right", "Right", "Attack"]:
			print("Cross")
			inputHistory.clear()
		["Down", "Left", "Attack"], ["Down", "Right", "Attack"]:
			print("Uppercut")
			inputHistory.clear()

func animate():
	match animation:
		IDLE:
			sprite.play("Idle")
			sprite.speed_scale = 1
		RUN:
			sprite.play("Run")
			sprite.speed_scale = abs(motion.x / 180)
		JUMP:
			sprite.play("Jump")
			sprite.speed_scale = 1
		FALL:
			sprite.play("Fall")
			sprite.speed_scale = 1

func coyote_time():
	yield(get_tree().create_timer(0.1), "timeout")
	canJump = false

func jump_buffer():
	yield(get_tree().create_timer(0.1), "timeout")
	jumpPressed = false

func log_input(event: String):
	inputTimer.start()
	if inputHistory.size() == 3:
		inputHistory.pop_front()
		inputHistory.push_back(event)
	else:
		inputHistory.push_back(event)

func _on_InputTimer_timeout():
	inputHistory.clear()
