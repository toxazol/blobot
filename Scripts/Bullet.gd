extends Area2D

@export var damage = 1

var speed = 100
var direction = Vector2(1,-1)


func _physics_process(delta):
	position += speed * delta * direction.normalized()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		hitPlayer(body)
		
func hitPlayer(body):
	body.takeDamage(damage)
	queue_free()
