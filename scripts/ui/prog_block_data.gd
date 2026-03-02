@tool
class_name ProgBlockData
extends Resource

@export var block_name : String:
	set = _set_block_name
	
@export var incoming_signals : Array[ProgSignalData] = []:
	set = _set_incoming
	
@export var outgoing_signals : Array[ProgSignalData] = []:
	set = _set_outgoing


func _set_block_name(value: String) -> void:
	block_name = value
	emit_changed()


func _set_incoming(value: Array[ProgSignalData]) -> void:
	incoming_signals = value
	emit_changed()


func _set_outgoing(value: Array[ProgSignalData]) -> void:
	outgoing_signals = value
	emit_changed()
