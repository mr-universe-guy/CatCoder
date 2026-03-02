@tool
class_name ProgBlock
extends PanelContainer

const prog_in_signal_scene = preload("res://scenes/ui/signal_in.tscn")
const prog_out_signal_scene = preload("res://scenes/ui/signal_out.tscn")

@export var block_data : ProgBlockData:
	set = _set_block_data

@onready var incoming_signals_container := $prog_block/incoming_signals
@onready var outgoing_signals_container := $prog_block/outgoing_signals

func _ready() -> void:
	_apply_data()


func _set_block_data(d : ProgBlockData) -> void:
	if block_data and block_data.changed.is_connected(_apply_data):
		block_data.changed.disconnect(_apply_data)
	
	block_data = d
	
	if block_data:
		block_data.changed.connect(_apply_data)
	
	_apply_data()


func _apply_data() -> void:
	if not is_node_ready():
		return
	
	for c in incoming_signals_container.get_children():
		c.queue_free()
	for c in outgoing_signals_container.get_children():
		c.queue_free()
	
	if block_data == null:
		return;
	
	for sig_data in block_data.incoming_signals:
		var scn : ProgSignal = prog_in_signal_scene.instantiate()
		scn.set_data(sig_data)
		incoming_signals_container.add_child(scn)
	
	for sig_data in block_data.outgoing_signals:
		var scn : ProgSignal = prog_out_signal_scene.instantiate()
		scn.set_data(sig_data)
		outgoing_signals_container.add_child(scn)
	
	var name_label : Label = $prog_block/name
	name_label.text = block_data.block_name
