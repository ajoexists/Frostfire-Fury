extends Node2D

var is_in_npc = false
var is_in_bonfire = false

func _ready():
	$Bonfire/Detect/Label.show()
	$Bala/OwO.show()

func _process(delta):
	if Input.is_action_just_pressed("E") and is_in_npc:
		$Bala/Label.hide()
		$Bala/Congrats.show()
		$Timer.start()
	if Input.is_action_just_pressed("E") and is_in_bonfire:
		$Won.won()
	
	if is_in_npc:
		$Bala/OwO.hide()
	else:
		$Bala/Label.hide()
		$Bala/Congrats.hide()
		$Bala/OwO.show()

func _on_Bala_body_entered(body):
	if body.is_in_group("Player"):
		is_in_npc = true
		$Bala/Label.show()
	

func _on_Bala_body_exited(body):
	if body.is_in_group("Player"):
		is_in_npc = false


func _on_Timer_timeout():
	$Bala/Congrats.hide()
	$Bala/Label.show()


func _on_Detect_body_entered(body):
	if body.is_in_group("Player"):
		is_in_bonfire = true
		$Bonfire/Detect/E.show()
		$Bonfire/Detect/Label.hide()


func _on_Detect_body_exited(body):
	if body.is_in_group("Player"):
		is_in_bonfire = false
		$Bonfire/Detect/E.hide()
		$Bonfire/Detect/Label.show()
