class_name ProgDebugLogic
extends ProgBlockLogic

func get_display_name() -> String:
	return "Debug"

func resolve(inputs: Array[int]) -> Array[int]:
	print("Debug: %s" % inputs)
	return []
