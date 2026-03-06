@tool
class_name ProgBlockData
extends Resource

@export var block_name : String:
	set = _set_block_name

@export var sockets: Array[ProgSocketData] = []:
	set = _set_sockets


func _set_block_name(value: String) -> void:
	block_name = value
	emit_changed()


func _set_sockets(value: Array[ProgSocketData]) -> void:
	sockets = value
	for s in sockets:
		s.block = self
	emit_changed()
