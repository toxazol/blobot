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
	# spawn bullets as children of the root node
	get_tree().root.get_child(0).add_child(bullet)
	bullet.global_position = $Crosshair.global_position
	var shootDir = $Crosshair.global_position - global_position
	var shootVel = shootDir.normalized() * BULLET_SPEED
	var moveVel = get_closest_rigidbody().linear_velocity
	bullet.velocity = moveVel + shootVel


func get_closest_rigidbody() -> RigidBody2D:
	var current_node = self
	while current_node:
		if current_node is RigidBody2D:
			return current_node
		current_node = current_node.get_parent()
	return null  # Return null if no RigidBody2D is found
