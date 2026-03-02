@tool
class_name ProgSignalData
extends Resource

enum ProgSignalType{ BOOL, NUMBER }

@export var signal_id : String:
	set = _set_id

@export var signal_type : ProgSignalType:
	set = _set_type

## The data being shared across this signal
@export var signal_data: int = 0


func _set_id(value: String) -> void:
	signal_id = value
	emit_changed()


func _set_type(value: ProgSignalType) -> void:
	signal_type = value
	emit_changed()
