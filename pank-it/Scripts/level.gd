extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_end():
	var get_sad_men = get_tree().get_nodes_in_group("sad_man")
	var sad_men = get_sad_men.count(get_sad_men)
	if Global.score == sad_men:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
