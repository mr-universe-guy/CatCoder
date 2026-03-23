class_name Noodler
extends Line2D

@export var data : NoodleData
@export var origin : Control:
	set = _set_origin
@export var destination : Control:
	set = _set_destination


func _init() -> void:
	add_point(Vector2(0,0))
	add_point(Vector2(0,0))


func _ready() -> void:
	_update_points()


func _set_origin(value: Control) -> void:
	if origin and origin.item_rect_changed.is_connected(_on_socket_change):
		origin.item_rect_changed.disconnect(_on_socket_change)
	origin = value
	if not value or not is_node_ready():
		return
	origin.item_rect_changed.connect(_on_socket_change)


func _set_destination(value: Control) -> void:
	if destination and destination.item_rect_changed.is_connected(_on_socket_change):
		destination.item_rect_changed.disconnect(_on_socket_change)
	destination = value
	if not value or not is_node_ready():
		return
	destination.item_rect_changed.connect(_on_socket_change)


func _on_socket_change() -> void:
	_update_points()


func _update_points() -> void:
	points[0] = origin.get_global_rect().get_center() if origin else Vector2.ZERO
	points [1] = destination.get_global_rect().get_center() if destination else Vector2.ZERO
