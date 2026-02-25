extends CharacterBody3D


const SPEED := 5.0
const JUMP_VELOCITY := 4.5


func _physics_process(delta: float) -> void:
	#get the active camera
	var cam: Camera3D = get_viewport().get_camera_3d()
	#get camera facing
	var cam_fwd := cam.global_transform.basis.z
	var cam_right := cam.global_transform.basis.x
	var fwd := cam_fwd.normalized()
	var right := cam_right.normalized()
	#user input
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (fwd * input_dir.y) + (right * input_dir.x)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
