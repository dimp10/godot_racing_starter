extends RigidBody2D

export var STEERING=300.0
export var ACCELERATION=50.0
export var FRICTION=2.0
export var DRIFT_FRICTION=0.8
export var DRIFT_STEERING=600.0

func _physics_process(delta):
	input()
	camera()
	sound()
	
func input():
	linear_damp=FRICTION
	if Input.is_action_pressed("ui_left"):
		apply_torque_impulse(-STEERING)
	if Input.is_action_pressed("ui_right"):
		apply_torque_impulse(STEERING)
	if Input.is_action_pressed("ui_up"):
		apply_central_impulse(Vector2(0, -ACCELERATION).rotated(rotation))
	if Input.is_action_pressed("ui_down"):
		apply_central_impulse(Vector2(0, ACCELERATION).rotated(rotation))

func sound():
	pass

func camera():
	pass

const Skidmark = preload("res://skidmark.tscn")

func doSkidmark():
	pass
