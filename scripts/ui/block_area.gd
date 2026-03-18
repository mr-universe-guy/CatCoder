extends Panel

var panning := false
var zoom_factor := 10:
	set = _set_zoom_factor

@onready var offset : Node2D = $offset

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var e := event as InputEventMouseButton
		if e.button_index == MouseButton.MOUSE_BUTTON_MIDDLE:
			panning = e.pressed
		if e.button_index == MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
			zoom_factor = mini(25, zoom_factor + 1)
		if e.button_index == MouseButton.MOUSE_BUTTON_WHEEL_UP:
			zoom_factor = max(4, zoom_factor - 1)
	
	elif event is InputEventMouseMotion:
		if not panning:
			return
		var e := event as InputEventMouseMotion
		offset.position += e.relative

func _set_zoom_factor(value: int) -> void:
	zoom_factor = value
	offset.scale = Vector2.ONE * 10.0/zoom_factor
