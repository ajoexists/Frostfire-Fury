extends Area2D

var smooth_mouse_pos: Vector2

var direction = Vector2.RIGHT
var speed = 0

func _ready():
	$Particles2D.process_material
	$Particles2D.emitting = true

func _process(delta):
	smooth_mouse_pos = lerp(smooth_mouse_pos, get_global_mouse_position(), 0.3)
	translate(direction.normalized() * speed * delta)
	

func _on_Bullet_body_entered(body):
	if body.is_in_group("Enemy"):
		body.die()
