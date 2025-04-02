extends CharacterBody3D
class_name Sad_Man


@onready var sprite = $Sprite3D

var is_happy = false


func _physics_process(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func _process(delta):
	GlobalVars.connect("honk_horn", _on_horn_honked)
	if is_happy == true:
		GlobalVars.score += 1
		sprite.texture = load("res://Assets/man_happy.png")

func _on_horn_honked():
	is_happy = true

func _on_area_entered(body):
	pass # Replace with function body.
