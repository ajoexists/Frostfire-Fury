extends KinematicBody2D

const enemy_bullet = preload("res://Scenes/EnemyBullet.tscn")

signal dead

var player

var speed = 40
var velocity: Vector2 = Vector2.ZERO

var path: Array = []
var level_navigation: Navigation2D = null
var player_nav = null

func _ready():
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		level_navigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player_nav = tree.get_nodes_in_group("Player")[0]

func _physics_process(_delta):
	if Global.player_dead:
		pass
	else:
		if player_nav and level_navigation:
			generate_path()
			navigate()
		move()
	if Global.player_dead:
		pass
	else:
		player = get_parent().get_node("Player")
	if Global.player_dead:
		pass
	else:
		look_at(player.position)
		if $ShootCD.is_stopped():
			shoot()
			$ShootCD.start()
	
	if Global.player_dead:
		pass
	else:
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
	if body.is_in_group("Player"):
		body.die()

func move():
	velocity = move_and_slide(velocity)

func die():
	emit_signal("dead")
	if Global.level_indicator == 1:
		Global.level_1 -= 1
	elif Global.level_indicator == 2:
		Global.level_2 -= 1
	elif Global.level_indicator == 3:
		Global.level_3 -= 1
	else:
		Global.tutorial -= 1
	queue_free()

func shoot():
	var bull = enemy_bullet.instance()
	bull.direction = $Position2D.global_position - global_position 
	bull.global_position = $Position2D.global_position
	get_tree().get_root().add_child(bull)
	$Shoot.play()

func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed

		if global_position == path [0]:
			path.pop_front()

func generate_path():
	if level_navigation != null and player_nav != null:
		path = level_navigation.get_simple_path(global_position, player_nav.global_position, false)
