extends CharacterBody3D
class_name Sad_Man


@onready var sprite = $Sprite3D
@onready var timer = $Timer
@onready var yesSFX = $AudioStreamPlayer3D

var is_happy = false
var player_found = false
var horn_heard = false
var score_changed = false


func _ready():
	timer.start()

func _physics_process(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func _process(delta):
	if player_found == true and horn_heard == true:
		is_happy = true
	
	if is_happy == true and not score_changed:
		score_changed = true
		Global.add_score()
	
	if is_happy == true and horn_heard == true and player_found == true:
		yesSFX.play()
	
	if not Global.honk_horn.is_connected(self._on_horn_honked):
		Global.connect("honk_horn", _on_horn_honked)
	
	if is_happy == true:
		sprite.texture = load("res://Assets/man_happy.png")

func _on_horn_honked():
	horn_heard = true

func _on_body_entered(body):
	if body is Player:
		player_found = true

func _on_body_exited(body):
	if body is Player:
		player_found = false

func _on_timer_timeout():
	horn_heard = false
