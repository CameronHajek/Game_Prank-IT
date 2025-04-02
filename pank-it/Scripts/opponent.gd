extends CharacterBody3D
class_name Sad_Man

signal become_happy()


@onready var sprite = $Sprite3D

var is_happy = false


func _physics_process(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func _process(delta):
	if is_happy == true:
		sprite.texture = load("res://Assets/man_happy.png")
