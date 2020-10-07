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
	var steering = Input.get_action_strength("steer_right2") - Input.get_action_strength("steer_left2")
	if Input.is_action_pressed("drift2"):
		apply_torque_impulse(DRIFT_STEERING * steering)
		linear_damp = DRIFT_FRICTION
		$skid.stream_paused = false
		doSkidmark()
	else:
		var acceleration = (Input.get_action_strength("accelerate2") - Input.get_action_strength("brake2")) * Vector2.UP * ACCELERATION
		apply_central_impulse(acceleration.rotated(rotation))
		apply_torque_impulse(STEERING * steering )
		linear_damp = FRICTION
		$skid.stream_paused = true

func sound():
	if linear_velocity.length()<0.1:
		print(linear_velocity.length())
		$engine.stop()
	else:
		$engine.play()
	$engine.pitch_scale = linear_velocity.length()/1000 + 0.1

func camera():
	var scalefactor = 1.5 + linear_velocity.length()/1000
	$Camera2D.zoom = lerp($Camera2D.zoom, Vector2(scalefactor,scalefactor), 0.01)

const Skidmark = preload("res://skidmark.tscn")

func doSkidmark():
	var skidmark = Skidmark.instance()
	skidmark.position = position
	skidmark.rotation = rotation
	get_node("/root/racetrack/skidmarks").add_child(skidmark)


func _on_player_body_entered(body):
	$crash.play()
