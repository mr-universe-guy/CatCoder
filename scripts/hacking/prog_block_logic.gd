class_name ProgBlockLogic
extends RefCounted

func get_display_name() -> String:
	return "Error"

func get_input_sockets() -> Array[ProgSocketData]:
	return []

func get_output_sockets() -> Array[ProgSocketData]:
	return []


## Resolve the block logic. Inputs = array of input sockets by declaration order.
## Return = an array of data to be written to the output sockets by declaration order.
func resolve(inputs: Array[int]) -> Array[int]:
	return []

func validate() -> bool:
	return false
