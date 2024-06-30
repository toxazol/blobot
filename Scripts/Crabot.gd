extends Node2D

@export var rotation_speed = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	#rotate(rotation_speed)
	pass


func _on_core_body_entered(body):
	if !body.is_in_group("Player"):
		return

	call_deferred("dismantle")

func dismantle():
	$Body/Broken.process_mode = Node.PROCESS_MODE_INHERIT
	$Body/Broken.reparent(get_parent())
	$Body.queue_free()
