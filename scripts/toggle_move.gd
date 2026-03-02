@tool
extends Node3D

## moves the first child node to the given transform when activated

@export var toggle := false:
	set = _on_toggle

@export var toggle_transform := Transform3D()
var tween : Tween

## The current transform becomes the toggle transform and the toggle transform becomes the current transform
func _on_toggle(value : bool) -> void:
	if tween and tween.is_running():
		return
	
	toggle = value
	var current := Transform3D(transform)
	
	if Engine.is_editor_hint():
		transform = toggle_transform
		toggle_transform = current
	else:
		tween = self.create_tween()
		tween.tween_property(self, "transform", toggle_transform, 1.0).from_current()
		tween.tween_callback(_finalize_transform.bind(current))
		tween.play()


func _finalize_transform(trans: Transform3D) -> void:
	toggle_transform = trans

func _on_interact(_player: Player) -> void:
	toggle = !toggle
