extends RigidBody2D

@export var force_magnitude: float = 500  # Adjust this to control the force strength

func _physics_process(delta: float) -> void:
	var force = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
	force = force.normalized() * force_magnitude
	apply_central_impulse(force * delta)
