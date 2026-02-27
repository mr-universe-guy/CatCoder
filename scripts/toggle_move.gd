@tool
extends Node3D

## moves the first child node to the given transform when activated

@export var toggle := false:
	set = _on_toggle

@export var toggle_transform := Transform3D()

## The current transform becomes the toggle transform and the toggle transform becomes the current transform
func _on_toggle(value : bool) -> void:
	toggle = value
	var temp := Transform3D(global_transform)
	global_transform = toggle_transform
	toggle_transform = temp


func _on_interact(player: Player) -> void:
	toggle = !toggle
