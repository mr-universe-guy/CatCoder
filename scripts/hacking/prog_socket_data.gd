@tool
class_name ProgSocketData
extends Resource
## ProgSocketData stores the data type, data direction and parent block.
## Prog Sockets exist for noodles to attach to.

enum ProgSignalDataType{ BOOL, NUMBER }
enum ProgSignalDirection{ IN, OUT }

## The name of this socket, it should be unique within the block
@export var signal_id : String:
	set = _set_id

## The type of data this socket can transmit
@export var signal_type : ProgSignalDataType:
	set = _set_data_type

## The direction this socket will transmit data
@export var direction: ProgSignalDirection:
	set = _set_direction

## The parent block for this data
@export var block: ProgBlockData

func _set_id(value: String) -> void:
	signal_id = value
	emit_changed()


func _set_data_type(value: ProgSignalDataType) -> void:
	signal_type = value
	emit_changed()


func _set_direction(v: ProgSignalDirection) -> void:
	direction = v
	emit_changed()


func is_noodle_possible(other: ProgSocketData) -> bool:
	if self == other:
		return false
	if direction == other.direction:
		return false
	if not signal_type == other.signal_type:
		return false
	return true
