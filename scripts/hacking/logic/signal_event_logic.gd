class_name ProgSignalEventLogic
extends ProgBlockLogic


func on_signal(data: int) -> void:
	pass

static func get_id() -> String:
	return "Event"

func get_input_sockets() -> Array[ProgSocketData]:
	return []

func get_output_sockets() -> Array[ProgSocketData]:
	return [
		ProgSocketData.create("received", ProgSocketData.DataType.BOOL, ProgSocketData.Direction.OUT)
	]
