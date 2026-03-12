@tool
class_name ProgBlock
extends PanelContainer

const prog_socket_scene = preload("res://scenes/ui/socket.tscn")

@export var block_data : ProgBlockData:
	set = _set_block_data

@onready var incoming_signals_container := $prog_block/incoming_sockets
@onready var outgoing_signals_container := $prog_block/outgoing_sockets


func _ready() -> void:
	_apply_data()


func _set_block_data(d : ProgBlockData) -> void:
	if block_data and block_data.changed.is_connected(_apply_data):
		block_data.changed.disconnect(_apply_data)
	
	block_data = d
	
	if block_data:
		block_data.changed.connect(_apply_data)
	
	_apply_data()


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_TRANSFORM_CHANGED:
			if block_data.locked:
				return
			block_data.position = position


func _apply_data() -> void:
	if not is_node_ready():
		return
	
	for c in incoming_signals_container.get_children():
		c.queue_free()
	for c in outgoing_signals_container.get_children():
		c.queue_free()
	
	if block_data == null:
		return
	
	var logic_id := block_data.logic_id
	var logic_data := ProgBlockRegistry.get_logic(logic_id)
	
	if logic_data == null:
		return
	
	for skt_data in logic_data.get_input_sockets():
		var skt : ProgSocket = prog_socket_scene.instantiate()
		skt.socket_data = skt_data
		incoming_signals_container.add_child(skt)
	
	for skt_data in logic_data.get_output_sockets():
		var skt : ProgSocket = prog_socket_scene.instantiate()
		skt.socket_data = skt_data
		outgoing_signals_container.add_child(skt)
	
	var name_label : Label = $prog_block/name
	name_label.text = block_data.block_name
	position = block_data.position
