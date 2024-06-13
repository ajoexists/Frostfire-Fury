extends KinematicBody2D

export(int) var jump_height = 160
export(int) var max_speed = 80
export(int) var acceleration = 20
export(int) var friciton = 15
export(int) var gravity = 8

var velocity = Vector2.ZERO
var double_jump = 1

func _ready():
	Global.player_dead = false

func _process(_delta):
	pass

func _physics_process(_delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ren_right") - Input.get_action_strength("ren_left")
	
	if input.x == 0:
		apply_friction()
		$Ren.play("Idle")
	else:
		apply_acceleration(input.x)
		$Ren.play("Run")
		if input.x < 0:
			$Ren.flip_h = true
		else:
			$Ren.flip_h = false

	if get_global_mouse_position().x > global_position.x:
		$Pistol.scale.x = 1
		$Pistol.scale.y = 1
		$Bullet.scale.x = 1
		$Bullet.scale.y = 1
	else:
		$Pistol.scale.y = -1
		$Bullet.scale.y = -1
	
	if is_on_floor():
		double_jump = 1 
		if Input.is_action_pressed("ren_jump"):
			$Jump.play()
			velocity.y -= jump_height
	else:
		$Ren.animation = "Jump"
		if Input.is_action_just_pressed("ren_jump") and double_jump == 1:
			double_jump = 0
			velocity.y = 0
			$Jump.play()
			velocity.y -= jump_height
			$Ren.animation = "Jump"
	
		if velocity.y > 5:
			$Ren.play("Fall")
		
	velocity = move_and_slide(velocity, Vector2.UP)

func die():
	Global.player_dead = true
	queue_free()

func apply_gravity():
	velocity.y += gravity 

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, friciton)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, max_speed * amount, acceleration)
