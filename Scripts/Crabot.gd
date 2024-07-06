extends Node2D

@export var torque = 20
@export var arm_count = 8
@export var arm_distance = 500

const armTemplate = preload("res://Templates/arm.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(arm_count) :
		initArm(i+1)
	
func initArm(i):
	var arm = armTemplate.instantiate()
	var rotator = Node2D.new()
	rotator.add_child(arm)
	add_child(rotator)
	arm.position.y = -arm_distance
	var angle = (2*PI / arm_count) * i
	rotator.rotate(angle)
	arm.reparent(self)
	
	var joint = PinJoint2D.new()
	joint.node_a = $Body.get_path()
	joint.node_b = arm.get_path()
	joint.motor_enabled = true
	joint.motor_target_velocity = torque
	$Body.add_child(joint)

func _physics_process(delta):
	pass
	


func _on_core_body_entered(body):
	if !body.is_in_group("Player"):
		return

	call_deferred("dismantle")

func dismantle():
	for part in get_children():
		if part.has_method("stopShooting"):
			part.stopShooting()
	for part in $Body/Broken.get_children():
		for sprite in part.get_children():
				if sprite.is_in_group("Intact"):
					sprite.visible = false
				elif sprite.is_in_group("Broken"):
					sprite.visible = true
	$Body/Broken.process_mode = Node.PROCESS_MODE_INHERIT
	$Body/Broken.reparent(get_parent())
	$Body.queue_free()
