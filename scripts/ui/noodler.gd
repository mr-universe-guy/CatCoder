class_name Noodler
extends Line2D

@export var data : NoodleData
@export var origin : ProgSocket:
	set = _set_origin
@export var destination : ProgSocket:
	set = _set_destination


func _init() -> void:
	add_point(Vector2(0,0))
	add_point(Vector2(0,0))


func _ready() -> void:
	_update_points()


func _set_origin(value: ProgSocket) -> void:
	if origin and origin.transform_changed.is_connected(_on_socket_change):
		origin.transform_changed.disconnect(_on_socket_change)
	origin = value
	if not origin:
		return
	
	origin.transform_changed.connect(_on_socket_change)


func _set_destination(value: ProgSocket) -> void:
	if destination and destination.transform_changed.is_connected(_on_socket_change):
		destination.transform_changed.disconnect(_on_socket_change)
	destination = value
	if not destination:
		return
	
	destination.transform_changed.connect(_on_socket_change)


func _on_socket_change() -> void:
	_update_points()


func _update_points() -> void:
	points[0] = origin.get_global_rect().get_center() if origin else Vector2.ZERO
	points [1] = destination.get_global_rect().get_center() if destination else Vector2.ZERO


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		_update_points()
