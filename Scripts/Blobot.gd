extends RigidBody2D

@export var force_magnitude: float = 500  # Adjust this to control the force strength
@export var fullHealth: float = 5
@export var curHealth: float
@export var progressBar: ProgressBar

func _ready():
	curHealth = fullHealth
	progressBar.max_value = fullHealth
	progressBar.value = curHealth

func _physics_process(delta: float) -> void:
	var force = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
	force = force.normalized() * force_magnitude
	apply_central_impulse(force * delta)

func takeDamage(damage):
	curHealth -= damage
	if curHealth <= 0.0:
		print("Game over :'c")
		get_tree().reload_current_scene()
		
	progressBar.value = curHealth
