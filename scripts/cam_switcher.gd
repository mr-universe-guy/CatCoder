class_name CamSwitcher
extends Camera3D

## a list of objects to show when this camera is activated
@export var show_on_activate: Array[Node3D] = []
## a list of objects to hide when this camera is activated
@export var hide_on_activate: Array[Node3D] = []


func make_camera_active() -> void:
	CameraManager.active_camera = self


## make this camera active. This will show/hide the listed objects
func _activate_cam() -> void:
	for node in show_on_activate:
		node.show()
	
	for node in hide_on_activate:
		node.hide()
	
	make_current()


## called when this camera is de-activated. 
## This will show the hidden objects and hide the shown objects.
func _deactivate_cam() -> void:
	for node in show_on_activate:
		node.hide()
	
	for node in hide_on_activate:
		node.show()
