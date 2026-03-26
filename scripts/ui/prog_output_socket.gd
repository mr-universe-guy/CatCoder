class_name ProgOutputSocket
extends ProgSocket


func _get_drag_data(_pos: Vector2) -> Variant:
	var data_map := {}
	var noodle_data := NoodleData.new()
	data_map["noodle_data"] = noodle_data
	
	noodle_data.from_socket = socket_data
	data_map["origin_socket"] = self
	
	var drag_target : Control = PREVIEW_SOCKET.instantiate()
	set_drag_preview(drag_target)
	
	ProgManager.device.begin_noodle_preview(noodle_data, self, drag_target)
	
	return data_map


func _can_drop_data(_pos: Vector2, data: Variant) -> bool:
	if not typeof(data) == TYPE_DICTIONARY:
		return false
	
	var data_map := data as Dictionary
	if not data_map.has("noodle_data"):
		return false
	
	var other: NoodleData = data_map["noodle_data"]
	
	if other.from_socket:
		return false
	
	return true


func _drop_data(pos: Vector2, data: Variant) -> void:
	assert(data is Dictionary and (data as Dictionary).has("noodle_data"), "Drop data does not contain noodle data")
	var data_map := data as Dictionary
	var noodle : NoodleData = data_map["noodle_data"]
	
	var origin : ProgSocket
	var destination : ProgSocket
	
	noodle.from_socket = socket_data
	origin = self
	destination = data_map["destination_socket"]
	ProgManager.device.add_noodle(noodle, origin, destination)
	
	ProgManager.device.end_noodle_preview()

	
