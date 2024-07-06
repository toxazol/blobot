extends Node2D

@export var BULLET_SPEED : float = 300
@export var FIRE_INTERVAL : float = 1

const bulletTemplate = preload("res://Templates/bullet.tscn")

var isStop = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var time = 0
func _process(delta):
	if isStop:
		return
	time += delta
	if time > FIRE_INTERVAL:
		shoot()
		time = 0

func stopShooting():
	isStop = true

func shoot():
	var bullet = bulletTemplate.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $Crosshair.global_position
	bullet.SPEED = BULLET_SPEED
	bullet.DIRECTION = $Crosshair.global_position - global_position
