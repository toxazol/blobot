extends RigidBody2D

@export var force_magnitude: float = 500  # Adjust this to control the force strength
@export var fullHealth: float = 5
@export var curHealth: float
@export var progressBar: ProgressBar
@export var isAugmented: bool = true
@export var augmentedRotateSpeed: float = 50

func _ready():
	curHealth = fullHealth
	progressBar.max_value = fullHealth
	progressBar.value = curHealth

func _physics_process(delta: float) -> void:
	var inputVec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if isAugmented:
		moveAugmented(inputVec, delta)
	else :
		move(inputVec, delta)
	
func move(inputVec, delta):
	var force = inputVec.normalized() * force_magnitude
	apply_central_impulse(force * delta)

func moveAugmented(inputVec, delta):
	var dir = $Cannon/Crosshair.global_position - global_position
	apply_torque_impulse(dir.angle_to(inputVec)*augmentedRotateSpeed)
	move(inputVec, delta)

func takeDamage(damage):
	curHealth -= damage
	if curHealth <= 0.0:
		print("Game over :'c")
		get_tree().reload_current_scene()
		
	progressBar.value = curHealth
