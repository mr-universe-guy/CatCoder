extends Node

var active_camera : CamSwitcher:
	set = _set_active_cam


func _set_active_cam(cam:CamSwitcher) -> void:
	if active_camera:
		active_camera._deactivate_cam()
	
	cam._activate_cam()
	
	active_camera = cam
	print("Camera swapped to %s" %cam)
