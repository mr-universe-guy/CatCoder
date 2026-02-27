class_name Player
extends CharacterBody3D


const SPEED := 5.0
const JUMP_VELOCITY := 4.5

var interactables : Array[Interactable] = []


func _physics_process(delta: float) -> void:
	#get the active camera
	var cam: Camera3D = get_viewport().get_camera_3d()
	
	#interactables
	if interactables.size() > 1:
		interactables.sort_custom(_sort_by_distance)
	
	if Input.is_action_just_pressed("interact") and not interactables.is_empty():
		interactables[0].interact(self)
	
	_process_movement(delta, cam)
	


func _process_movement(delta: float, cam: Camera3D) -> void:
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
		
		##face direction
		var heading := atan2(direction.x, -direction.z)
		var heading_rot := Basis.from_euler(Vector3(0, -heading, 0))
		global_basis = global_basis.slerp(heading_rot, 0.1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_interact_entered(other: Node3D) -> void:
	if other is Interactable:
		var target := other as Interactable
		print("%s" % target.display_text)
		interactables.append(target)


func _on_interact_exited(other: Node3D) -> void:
	if other is Interactable:
		var target := other as Interactable
		interactables.erase(target)


func _sort_by_distance(a : Node3D, b : Node3D) -> bool:
	var dist_a := global_position.distance_squared_to(a.global_position)
	var dist_b := global_position.distance_squared_to(b.global_position)
	return dist_a < dist_b
