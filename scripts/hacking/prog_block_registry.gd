@tool
extends Node

var registry : Dictionary[String, ProgBlockLogic] = {
	ProgDebugLogic.get_id(): ProgDebugLogic.new(),
	ProgSignalEventLogic.get_id(): ProgSignalEventLogic.new()
}


func  register(logic_class: ProgBlockLogic) -> void:
	registry[logic_class.get_id()] = logic_class


func get_logic(id: String) -> ProgBlockLogic:
	if not registry.has(id):
		push_error("Unknown block logic: " + id)
		return null
	return registry[id]
