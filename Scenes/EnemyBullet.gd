extends Area2D

var direction = Vector2.RIGHT
var speed = 100

func _ready():
	pass 

func _physics_process(delta):
	translate(direction.normalized() * speed * delta)

func _on_EnemyBullet_body_entered(body):
	if body.is_in_group("Tile"):
		speed = 0
		$Sprite.visible = false
		$Particles2D.emitting = true
		$Timer.start()
	if body.is_in_group("Player"):
		body.die()
		$PlayerDie.play()
		speed = 0
		$Sprite.visible = false
		$Particles2D.emitting = true
		$Timer.start()
		
func _on_Timer_timeout():
	queue_free()

