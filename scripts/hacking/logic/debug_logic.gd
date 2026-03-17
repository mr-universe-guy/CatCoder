class_name ProgDebugLogic
extends ProgBlockLogic

static func get_id() -> String:
	return "Debug"

func resolve(inputs: Array[int]) -> Array[int]:
	print("Debug: %s" % inputs)
	return []
