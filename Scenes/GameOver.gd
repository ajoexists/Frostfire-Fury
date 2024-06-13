extends CanvasLayer

func _ready():
	pass # Replace with function body.

func game_over():
	$Timer.start()
	$AnimationPlayer.play("Fade")
	

func _process(delta):
	if Global.player_dead == true:
		if $CD.is_stopped():
			game_over()
			$CD.start()

func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/Tutorial.tscn")


func _on_Timer_timeout():
	$YouDied.show()
	$ClickLabel.show()
	$Restart.show()
