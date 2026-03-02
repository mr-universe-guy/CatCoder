@tool
class_name ProgSignal
extends HBoxContainer

enum ProgSignalType{
	BOOL, NUMBER
}

const TEX_BOOL := preload("res://assets/kenney/ui/UIPack/icon_outline_circle.png")
const TEX_NUMBER := preload("res://assets/kenney/ui/UIPack/icon_outline_square.png")

@export var signal_data : ProgSignalData


func set_data(d: ProgSignalData) -> void:
	if signal_data:
		signal_data.changed.disconnect(_apply_data)
	
	signal_data = d
	signal_data.changed.connect(_apply_data)
	
	_apply_data()


func _apply_data() -> void:
	if signal_data == null:
		return
	var name_label : Label = $name
	name_label.text = signal_data.signal_id
	
	var socket : TextureRect = $socket
	match signal_data.signal_type:
		ProgSignalType.BOOL:
			socket.texture = TEX_BOOL
		ProgSignalType.NUMBER:
			socket.texture = TEX_NUMBER
