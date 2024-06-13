extends CanvasLayer

func _ready():
	pass # Replace with function body.

func won():
	if $CD.is_stopped():
		$Timer.start()
		$AnimationPlayer.play("Fade")
		$CD.start()

func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/Tutorial.tscn")

func _on_Timer_timeout():
	$YouDied.show()
	$ClickLabel.show()
	$Restart.show()
