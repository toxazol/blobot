extends Area2D

@export var damage = 1

var velocity: Vector2 


func _physics_process(delta):
	position += velocity * delta


func _on_body_entered(body):
	if body.is_in_group("Player"):
		hitPlayer(body)
		
func hitPlayer(body):
	body.takeDamage(damage)
	queue_free()
