extends Node2D

func _ready():
	Global.level_indicator = 0
	Global.tutorial = 2

func _process(delta):
	if Global.tutorial == 0:
		Global.block = true

func _on_Transition_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://Scenes/Level1.tscn")


func _on_Enemy1_dead():
	$Shake.shake()


func _on_Enemy2_dead():
	$Shake.shake()
