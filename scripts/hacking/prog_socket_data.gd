@tool
class_name ProgSocketData
extends Resource
## ProgSocketData stores the data type, data direction and parent block.
## Prog Sockets exist for noodles to attach to.

enum DataType{ BOOL, NUMBER }
enum Direction{ IN, OUT }

## The name of this socket, it should be unique within the block
@export var signal_id : String:
	set = _set_id

## The type of data this socket can transmit
@export var signal_type : DataType:
	set = _set_data_type

## The direction this socket will transmit data
@export var direction: Direction:
	set = _set_direction

## The parent block for this data
@export var block: ProgBlockData


static func create(_id: String, _type: DataType, _direction: Direction) -> ProgSocketData:
	var socket := ProgSocketData.new()
	socket.signal_id = _id
	socket.signal_type = _type
	socket.direction = _direction
	return socket


func _set_id(value: String) -> void:
	signal_id = value
	emit_changed()


func _set_data_type(value: DataType) -> void:
	signal_type = value
	emit_changed()


func _set_direction(v: Direction) -> void:
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
