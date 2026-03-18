extends PanelContainer


var _prog_block := preload("res://scenes/ui/prog_block.tscn")
var cur_program: ProgData = ProgData.new() : 
	set = _set_program

@onready var _block_list : VBoxContainer = $VBoxContainer/GridContainer/ToolTabs/Blocks/VBox
@onready var _block_scene : Node2D = $VBoxContainer/GridContainer/block_working_area/block_area/blocks
@onready var _var_list : ItemList = $VBoxContainer/GridContainer/ToolTabs/Variables/VBoxContainer/VariableList


## load the program data and create the scene to interact with
func _set_program(program: ProgData) -> void:
	pass


func upload_hack() -> void:
	pass


func _ready() -> void:
	display_block_tools()
	display_variables()


#region Blocks

func display_block_tools() -> void:
	for child : Node in _block_list.get_children():
		child.queue_free()
	
	for key in ProgBlockRegistry.registry:
		# for now just make a simple button
		var logic := ProgBlockRegistry.get_logic(key)
		var block_button := Button.new()
		block_button.text = key
		block_button.pressed.connect(create_block_from_id.bind(key))
		
		_block_list.add_child(block_button)


func create_block_from_id(id: String) -> void:
	print("%s was clicked" % id)
	# create a prog_block with the block logic from this id and drop it in the blocks node
	var data := ProgBlockData.new()
	data.logic_id = id
	
	cur_program.prog_blocks.append(data)
	
	var vis: ProgBlock = ProgBlock.create_from_data(data)
	_block_scene.add_child(vis)


func draw_all_blocks_from_data() -> void:
	pass


func remove_focused_block() -> void:
	var focus := get_viewport().gui_get_focus_owner()
	print(focus)
	if not focus:
		return
	if focus is not ProgBlock:
		return
	var block := focus as ProgBlock
	var data := block.block_data
	cur_program.prog_blocks.erase(data)
	block.queue_free()

#endregion


#region Variables

func create_variable() -> void:
	cur_program.variable_ids.append("Var_%s" % cur_program.variable_ids.size())
	pass


func display_variables() -> void:
	_var_list.clear()
	for v in cur_program.variable_ids:
		_var_list.add_item(v)


func _on_variable_name_field_text_submitted(new_text: String) -> void:
	if new_text == null or new_text.is_empty():
		return
	# for now limit all variables to upper case only
	var name := new_text.to_upper()
	# verify this variable does not already exist
	if cur_program.variable_ids.has(name):
		# TODO: some sort of failure state / popup
		return
	cur_program.variable_ids.append(name)
	
	display_variables()


func _on_remove_var_button_pressed() -> void:
	# TODO: some sore of failure state / popup
	if not _var_list.is_anything_selected():
		return
	
	var i := _var_list.get_selected_items()[0]
	cur_program.variable_ids.remove_at(i)
	
	display_variables()

#endregion

# TODO: drag and drop trash can and trash can that can delete previously focused block
func _on_trash_can_pressed() -> void:
	remove_focused_block()
