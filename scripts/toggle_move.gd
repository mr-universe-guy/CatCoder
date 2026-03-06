@tool
extends Node3D

## moves the first child node to the given transform when activated

@export var toggle := false:
	set = _on_toggle

@export var off_transform := Transform3D()
@export var on_transform := Transform3D()
@warning_ignore("unused_private_class_variable")
@export_tool_button("Record current transform") var _rec_action := _record
@export var duration := 1.0
@export var transition := Tween.TransitionType.TRANS_LINEAR
var tween : Tween

## The current transform becomes the toggle transform and the toggle transform becomes the current transform
func _on_toggle(value : bool) -> void:
	if tween and tween.is_running():
		return
	
	toggle = value
	
	var tgt_trans: Transform3D
	if toggle:
		tgt_trans = on_transform
	else:
		tgt_trans = off_transform
	
	tween = self.create_tween()
	tween.tween_property(self, "transform", tgt_trans, duration).from_current().set_trans(transition)
	


func _record() -> void:
	if toggle:
		on_transform = Transform3D(transform)
	else:
		off_transform = Transform3D(transform)


func _on_interact(_player: Player) -> void:
	toggle = !toggle
