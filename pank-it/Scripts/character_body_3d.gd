extends CharacterBody3D
class_name Player


@onready var score_lable = $ScoreUI
@onready var honk_counter = $HonkCounter
@onready var horn = $TextureRect
@onready var hornSfx = $HornSFX

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.25

var fullscreen = false

var times_honked = 0
var sadness_found = false


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event.is_action_pressed("enter_fullscreen"):
		var mode = DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event is InputEventMouseMotion:
		rotation_degrees.y -= MOUSE_SENS * event.relative.x
	
	if Input.is_action_just_pressed("honk_horn"):
		Global._emit_honk()
		horn.scale = Vector2(1, 0.75)
		hornSfx.play()
		times_honked += 1

func _physics_process(delta):
	score_lable.text = "Score: %s" % Global.score
	honk_counter.text = "Times Honked: %s" % times_honked
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _process(delta):
	# Returns the scale of the player's hand to the default.
	horn.scale.y = move_toward(horn.scale.y, 1, 1 * delta)
	
	# Exits the current scene with the "Esc" key
	if Input.is_action_just_pressed("exit_game"):
		get_tree().quit()
