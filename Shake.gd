extends Node2D

var shakestrength = 1
var randomshakestrength = 5

onready var shakedecay = 10
onready var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()

func _process(delta):
	shakestrength = lerp(shakestrength, 0, shakedecay * delta)
	$Camera2D.offset = get_random_offset()
	
func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shakestrength, shakestrength),
		rand.randf_range(-shakestrength, shakestrength)
	)
	rand.randf

func shake():
	shakestrength = randomshakestrength
