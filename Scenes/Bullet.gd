extends Area2D

var direction = Vector2.RIGHT
var speed = 200

func _ready():
	pass

func _process(delta):
	translate(direction.normalized() * speed * delta)
	

func _on_Bullet_body_entered(body):
	if body.is_in_group("Tile"):
		speed = 0
		$Sprite.visible = false
		$Particles2D.emitting = true
		$Timer.start()
	if body.is_in_group("Enemy"):
		body.die()
		$EnemyDie.play()
		speed = 0
		$Sprite.visible = false
		$Particles2D.emitting = true
		$Timer.start()

func _on_Timer_timeout():
	queue_free()
