@tool
class_name ProgBlockData
extends Resource
## ProgBlockData stores the name, logic_id and position of a program block in the scene.

	
## The logic id of the ProgBlockLogic this block references.
@export var logic_id: String:
	set = _set_logic_id

## Locks the player from moving or editing this block
@export var locked:= false

## The position of the data block in reference to the data scene
@export var position:= Vector2(0,0)


func _set_logic_id(value: String) -> void:
	logic_id = value
	emit_changed()
