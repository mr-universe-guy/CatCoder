extends Control

func _ready() -> void:
	if DisplayServer.is_touchscreen_available():
		show()
	else:
		hide()
