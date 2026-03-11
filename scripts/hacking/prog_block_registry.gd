extends Node

var _registry : Dictionary[String, ProgBlockLogic] = {
	
}


func  register(id: String, logic_class: ProgBlockLogic) -> void:
	_registry[id] = logic_class

func get_logic(id: String) -> ProgBlockLogic:
	if not _registry.has(id):
		push_error("Unknown block logic: " + id)
		return null
	return _registry[id]
