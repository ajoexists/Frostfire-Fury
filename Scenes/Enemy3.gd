extends KinematicBody2D

const enemy_bullet = preload("res://Scenes/EnemyBullet.tscn")

var player_detect = false
var player
func _physics_process(delta):
	player = get_parent().get_node("Player")
	if player_detect:
		look_at(player.position)
		if $ShootCD.is_stopped():
			shoot()
			$ShootCD.start()
	
	if player.position.x > global_position.x:
		$EnemyBullet.scale.x = 1
		$EnemyBullet.scale.y = 1
		$AnimatedSprite.scale.x = 1
		$AnimatedSprite.scale.y = 1
		$Position2D.scale.x = 1
		$Position2D.scale.y = 1
	else:
		$EnemyBullet.scale.y = -1
		$AnimatedSprite.scale.y = -1
		$Position2D.scale.y = -1


func _on_BulletDetect_body_entered(body):
	if body.is_in_group("Bullet"):
		die()

func die():
	pass

func shoot():
	var bull = enemy_bullet.instance()
	bull.direction = $Position2D.global_position - global_position 
	bull.global_position = $Position2D.global_position
	get_tree().get_root().add_child(bull)

func _on_PlayerDetect_body_entered(body):
	player_detect = true
