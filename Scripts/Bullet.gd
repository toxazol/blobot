extends CharacterBody2D


var SPEED = 100
var DIRECTION = Vector2(1,-1)


func _physics_process(delta):
	move_and_collide(SPEED * delta * DIRECTION.normalized())
