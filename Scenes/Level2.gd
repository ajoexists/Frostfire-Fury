extends Node2D

func _ready():
	Global.level_indicator = 2
	Global.level_2 = 5
	
func _process(delta):
	if Global.level_2 == 0:
		Global.block = true


func _on_Transition_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://Scenes/Level3.tscn")


func _on_Enemy1_dead():
	$Shake.shake()


func _on_Enemy6_dead():
	$Shake.shake()


func _on_Enemy2_dead():
	$Shake.shake()


func _on_Enemy4_dead():
	$Shake.shake()


func _on_Enemy5_dead():
	$Shake.shake()
