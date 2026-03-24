@tool
class_name ProgSocket
extends HBoxContainer


signal transform_changed

const PREVIEW_SOCKET := preload("res://scenes/ui/preview_socket.tscn")

@export var socket_data : ProgSocketData:
	set = _set_data

@onready var socket_glyph : Control = $socket

func _ready() -> void:
	set_notify_transform(true)
	if not socket_data:
		return
	
	_apply_data()


func _set_data(d: ProgSocketData) -> void:
	if socket_data:
		socket_data.changed.disconnect(_apply_data)
	
	socket_data = d
	if not socket_data:
		return
	
	socket_data.changed.connect(_apply_data)
	_apply_data()


func _apply_data() -> void:
	if not is_node_ready() or socket_data == null:
		return
	
	var name_label := $name as Label
	name_label.text = socket_data.signal_id


func get_noodle_position() -> Vector2:
	if not socket_glyph:
		return position
	else:
		return socket_glyph.get_global_rect().get_center()


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		transform_changed.emit()
