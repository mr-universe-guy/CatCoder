@tool
class_name ProgSocket
extends HBoxContainer


const TEX_BOOL := preload("res://assets/kenney/ui/UIPack/icon_outline_circle.png")
const TEX_NUMBER := preload("res://assets/kenney/ui/UIPack/icon_outline_square.png")


@export var socket_data : ProgSocketData:
	set = _set_data
	

func _ready() -> void:
	_apply_data()


func _set_data(d: ProgSocketData) -> void:
	if socket_data:
		socket_data.changed.disconnect(_apply_data)
	
	socket_data = d
	socket_data.changed.connect(_apply_data)
	
	_apply_data()


func _apply_data() -> void:
	if not is_node_ready() or socket_data == null:
		return
	
	var name_label := $name as Label
	name_label.text = socket_data.signal_id
	
	var socket : TextureRect = $socket
	match socket_data.signal_type:
		ProgSocketData.DataType.BOOL:
			socket.texture = TEX_BOOL
		ProgSocketData.DataType.NUMBER:
			socket.texture = TEX_NUMBER
