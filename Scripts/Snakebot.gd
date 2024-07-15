extends RigidBody2D

@export var force_magnitude: float = 500
@export var angle_step: float = 10
@export var target: Node2D
@export var neck: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var old_dir = global_position - neck.global_position
	old_dir = old_dir.normalized()
	var dir = target.global_position - global_position
	dir = dir.normalized()
	var angle_to_target = old_dir.angle_to(dir)
	var step_angle = angle_to_target / angle_step
	var new_dir = old_dir.rotated(step_angle)
	var force = force_magnitude * new_dir
	apply_central_impulse(force * delta)
