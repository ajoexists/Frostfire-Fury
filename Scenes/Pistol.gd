extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")

var smooth_mouse_pos: Vector2

var is_shooting = false

func _ready():
	pass 

func _process(_delta):
	smooth_mouse_pos = lerp(smooth_mouse_pos, get_global_mouse_position(), 0.3)
	look_at(smooth_mouse_pos)
	
	if Input.is_action_pressed("ren_shoot"):
		if $ShootCD.is_stopped():
			shoot()
			$AnimatedSprite.play("Fire")
			$ShootCD.start()
	else: 
		$AnimatedSprite.play("Default")

func shoot():
	var bull = bullet.instance()
	bull.direction = $Position2D.global_position - global_position 
	bull.global_position = $Position2D.global_position
	get_tree().get_root().add_child(bull)
	$Shoot.play()
