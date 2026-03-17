@tool
class_name ProgSocket
extends HBoxContainer

enum ProgSocketDataType{
	BOOL, NUMBER
}

enum ProgSocketDirection{
	IN,OUT
}

const TEX_BOOL := preload("res://assets/kenney/ui/UIPack/icon_outline_circle.png")
const TEX_NUMBER := preload("res://assets/kenney/ui/UIPack/icon_outline_square.png")


@export var socket_data : ProgSocketData:
	set = _set_data

#@onready var noodler: Noodler = $Noodler

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
		ProgSocketDataType.BOOL:
			socket.texture = TEX_BOOL
		ProgSocketDataType.NUMBER:
			socket.texture = TEX_NUMBER
	
	match socket_data.direction:
		ProgSocketDirection.IN:
			print("in")
			move_child($socket, 0)
		ProgSocketDirection.OUT:
			print("out")
			move_child($socket, -2)


## This should signal the beginning of a drag
func _get_drag_data(_at_position: Vector2) -> Variant:
	#var noodle := Noodler.new()
	#noodle.origin = $socket
	#set_drag_preview(noodle)
	return socket_data


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is not ProgSocketData:
		return false
	var other := data as ProgSocketData
	return socket_data.is_noodle_possible(other)


#func _drop_data(at_position: Vector2, data: Variant) -> void:
	#assert(data is ProgSocketData, "Drop data does not contain ProgSocketData")
	#
	#var skt_b := data as ProgSocketData
	#if socket_data.attach_noodle(skt_b):
		#print("Noodle successful")
	#else:
		#print("Noodle failed")


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		print("Drag ended")
