extends Node

signal honk_horn
signal update_score


var score = 0


func _emit_honk():
	honk_horn.emit()

func add_score():
	score += 1
	update_score.emit(score)
