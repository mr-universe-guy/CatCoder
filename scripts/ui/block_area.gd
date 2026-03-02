extends ColorRect





func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventPanGesture:
		print("Panning")
