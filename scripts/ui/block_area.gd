extends ColorRect
## BlockArea controls the user interaction with the hacking scene.

const block_scn := preload("res://scenes/ui/prog_block.tscn")

@onready var blocks := $blocks
@onready var noodles := $noodles


func load_program(program: ProgData) -> void:
	for child in blocks.get_children():
		child.queue_free()
	for noodle in noodles.get_children():
		noodle.queue_free()
	
	for block in program.prog_blocks:
		var block_node : ProgBlock = block_scn.instantiate()
		block_node.block_data = block
		blocks.add_child(block_node)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventPanGesture:
		print("Panning")
