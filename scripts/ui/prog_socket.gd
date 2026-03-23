@tool
class_name ProgSocket
extends HBoxContainer


const TEX_BOOL := preload("res://assets/kenney/ui/UIPack/icon_outline_circle.png")
const TEX_NUMBER := preload("res://assets/kenney/ui/UIPack/icon_outline_square.png")


@export var socket_data : ProgSocketData:
	set = _set_data

@export var incoming_noodle : Noodler

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


## This should signal the beginning of a drag
## TODO: use a dictionary to set the data needed for the editor, later we'll figure
## out about converting to custom classes
func _get_drag_data(_at_position: Vector2) -> Variant:
	var data_map := {}
	var noodle_data := NoodleData.new()
	data_map["noodle_data"] = noodle_data
	
	if socket_data.direction == ProgSocketData.Direction.IN:
		if incoming_noodle:
			print("Use existing noodle")
			data_map["origin_socket"] = incoming_noodle.origin
			noodle_data = incoming_noodle.data
			noodle_data.to_socket = null
			ProgManager.device.remove_noodle(incoming_noodle)
		else:
			noodle_data.to_socket = socket_data
			data_map["destination_socket"] = self
	else:
		# outgoing sockets can have multiple outgoing noodles so this should be fine
		noodle_data.from_socket = socket_data
		data_map["origin_socket"] = self
	
	var drag_target := Control.new()
	set_drag_preview(drag_target)
	
	ProgManager.device.begin_noodle_preview(self, drag_target)
	
	return data_map


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if not typeof(data) == TYPE_DICTIONARY:
		return false
	
	var data_map := data as Dictionary
	if not data_map.has("noodle_data"):
		return false
	
	var other : NoodleData = data_map["noodle_data"]
	
	if socket_data.direction == ProgSocketData.Direction.IN:
		if other.to_socket:
			return false
	else:
		if other.from_socket:
			return false
	
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	assert(data is Dictionary and (data as Dictionary).has("noodle_data"), "Drop data does not contain Noodle Data")
	
	var data_map := data as Dictionary
	var noodle : NoodleData = data_map["noodle_data"]
	
	var origin : ProgSocket
	var destination: ProgSocket
	
	if socket_data.direction == ProgSocketData.Direction.IN:
		##TODO: if this is an incoming socket and it already has a noodle, destroy that noodle
		if incoming_noodle:
			pass
		
		noodle.to_socket = socket_data
		origin = data_map["origin_socket"]
		destination = self
		incoming_noodle = ProgManager.device.add_noodle(noodle, origin, destination)
	else:
		noodle.from_socket = socket_data
		origin = self
		destination = data_map["destination_socket"]
		ProgManager.device.add_noodle(noodle, origin, destination)
	
	ProgManager.device.end_noodle_preview()


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		print("Drag ended")
