class_name Noodler
extends Line2D

@export var data : NoodleData
@export var origin : ProgSocket:
	set = _set_origin
@export var destination : ProgSocket:
	set = _set_destination
var preview := false

func _init() -> void:
	begin_cap_mode = Line2D.LINE_CAP_ROUND
	end_cap_mode = Line2D.LINE_CAP_ROUND
	antialiased = true
	default_color = Color.HOT_PINK
	
	add_point(Vector2(0,0))
	add_point(Vector2(0,0))



func _ready() -> void:
	_update_points()


func _set_origin(value: ProgSocket) -> void:
	if origin:
		if origin.transform_changed.is_connected(_on_socket_change):
			origin.transform_changed.disconnect(_on_socket_change)
		if origin.removed_from_canvas.is_connected(_on_socket_removed):
			origin.removed_from_canvas.disconnect(_on_socket_removed)
	origin = value
	if not origin:
		return
	
	origin.transform_changed.connect(_on_socket_change)
	
	if preview:
		return
	
	origin.removed_from_canvas.connect(_on_socket_removed)
	


func _set_destination(value: ProgSocket) -> void:
	if destination:
		if destination.transform_changed.is_connected(_on_socket_change):
			destination.transform_changed.disconnect(_on_socket_change)
		if destination.removed_from_canvas.is_connected(_on_socket_removed):
			destination.removed_from_canvas.disconnect(_on_socket_removed)
	destination = value
	if not destination:
		return
	
	destination.transform_changed.connect(_on_socket_change)
	
	if preview:
		return
	
	destination.removed_from_canvas.connect(_on_socket_removed)


func _on_socket_change() -> void:
	_update_points()

## destroy self 
func _on_socket_removed() -> void:
	ProgManager.device.remove_noodle(data)


func _update_points() -> void:
	var offset := ProgManager.device.offset_node
	points[0] = offset.to_local(origin.get_noodle_position()) if origin else Vector2.ZERO
	points [1] = offset.to_local(destination.get_noodle_position()) if destination else Vector2.ZERO


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		_update_points()
